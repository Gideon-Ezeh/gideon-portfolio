/* ============================================================================
   POCKETPATH — "The Stickiness Cliff" investigation
   Rebuilds DAU/MAU stickiness from raw events + users tables.
   All timestamps are UTC. MAU = rolling 28 days ending on each day
   (per the brief — NOT calendar month).

   Assumes:
     events(user_id, event_ts, event_name, app_version, platform)
     users (user_id, signup_date, platform, acquisition_channel, is_internal)

   NOTE on event_ts: source CSV is dd/mm/yyyy (day-first). If event_ts landed
   as VARCHAR on import, CAST(... AS date) below will throw or silently
   misparse depending on your server's LANGUAGE/DATEFORMAT setting — safer to
   use TRY_CONVERT(date, event_ts, 103) explicitly. Swap the CAST for that if
   your import didn't already parse it into a real datetime column.

   NOTE on is_internal: source CSV stores literal text 'TRUE'/'FALSE'. If your
   import created this as VARCHAR, compare with UPPER() as below. If it came
   in as BIT (import wizard auto-detected it), replace the CASE expression
   with just `u.is_internal` directly — comparing a BIT column to a string
   will error, not silently mismatch.
   ============================================================================ */

-- ---------------------------------------------------------------------------
-- STEP 0 — Diagnostic: exact-duplicate events (the iOS double-logging bug)
-- Run this first, purely to confirm scope/timing before it affects anything
-- downstream. This does NOT feed the stickiness numbers below.
-- ---------------------------------------------------------------------------
SELECT
    CAST(e.event_ts AS date) AS event_date,
    e.platform,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(DISTINCT CONCAT(e.user_id,'|',e.event_ts,'|',e.platform)) AS exact_duplicate_rows
FROM events e
WHERE e.event_name = 'app_open'
GROUP BY CAST(e.event_ts AS date), e.platform
HAVING COUNT(*) - COUNT(DISTINCT CONCAT(e.user_id,'|',e.event_ts,'|',e.platform)) > 0
ORDER BY event_date, e.platform;
-- Expect: a trickle of duplicates throughout, then a sharp step-change on
-- iOS starting 17 Aug (well after the 10 Aug release) — confirming this is
-- a distinct, later-onset issue, not the driver of the 3-9 vs 10-16 Aug drop.


-- ---------------------------------------------------------------------------
-- STEP 1 — One row per user per UTC day who opened the app, tagged internal.
-- DISTINCT here also neutralises the double-logging bug for THIS metric,
-- since we only care about unique active user-days, not raw event counts.
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS daily_active_users;

SELECT DISTINCT
    e.user_id,
    CAST(e.event_ts AS date) AS activity_date,
    CASE WHEN UPPER(u.is_internal) = 'TRUE' THEN 1 ELSE 0 END  AS is_internal
INTO daily_active_users
FROM events e
JOIN users u
    ON u.user_id = e.user_id
WHERE e.event_name = 'app_open';

CREATE INDEX ix_dau_date ON daily_active_users(activity_date) INCLUDE (user_id, is_internal);


-- ---------------------------------------------------------------------------
-- STEP 2 — Calendar spine covering the full observed range.
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS calendar;

;WITH bounds AS (
    SELECT MIN(activity_date) AS min_dt, MAX(activity_date) AS max_dt
    FROM daily_active_users
),
spine AS (
    SELECT min_dt AS activity_date FROM bounds
    UNION ALL
    SELECT DATEADD(day, 1, activity_date)
    FROM spine, bounds
    WHERE spine.activity_date < bounds.max_dt
)
SELECT activity_date
INTO calendar
FROM spine
OPTION (MAXRECURSION 0);


-- ---------------------------------------------------------------------------
-- STEP 3 — Segment view: All / External / Internal, so the artifact is
-- visible side by side instead of having to re-run the script three times.
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS dau_segmented;

SELECT activity_date, user_id, 'All'  AS segment INTO dau_segmented FROM daily_active_users
UNION ALL
SELECT activity_date, user_id, 'External' FROM daily_active_users WHERE is_internal = 0
UNION ALL
SELECT activity_date, user_id, 'Internal' FROM daily_active_users WHERE is_internal = 1;


-- ---------------------------------------------------------------------------
-- STEP 4 — Daily DAU and rolling 28-day MAU per segment.
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS daily_dau;
SELECT segment, activity_date, COUNT(DISTINCT user_id) AS dau
INTO daily_dau
FROM dau_segmented
GROUP BY segment, activity_date;

DROP TABLE IF EXISTS daily_mau;
SELECT c.activity_date, s.segment, COUNT(DISTINCT s.user_id) AS mau
INTO daily_mau
FROM calendar c
JOIN dau_segmented s
    ON s.activity_date BETWEEN DATEADD(day, -27, c.activity_date) AND c.activity_date
GROUP BY c.activity_date, s.segment;


-- ---------------------------------------------------------------------------
-- STEP 5 — Daily stickiness, then weekly averages for the two weeks in
-- question (plus the third week, for the double-logging context).
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS daily_stickiness;
SELECT
    d.segment,
    d.activity_date,
    d.dau,
    m.mau,
    CAST(d.dau AS decimal(10,4)) / m.mau AS stickiness
INTO daily_stickiness
FROM daily_dau d
JOIN daily_mau m
    ON m.activity_date = d.activity_date
    AND m.segment = d.segment;

SELECT
    segment,
    CASE
        WHEN activity_date BETWEEN '2026-08-03' AND '2026-08-09' THEN '1) Week before (3-9 Aug)'
        WHEN activity_date BETWEEN '2026-08-10' AND '2026-08-16' THEN '2) Week after  (10-16 Aug)'
        WHEN activity_date BETWEEN '2026-08-17' AND '2026-08-23' THEN '3) Week 3      (17-23 Aug)'
    END AS week_bucket,
    AVG(CAST(dau AS decimal(10,2))) AS avg_dau,
    AVG(CAST(mau AS decimal(10,2))) AS avg_mau,
    ROUND(AVG(stickiness) * 100, 1) AS avg_stickiness_pct
FROM daily_stickiness
WHERE activity_date BETWEEN '2026-08-03' AND '2026-08-23'
GROUP BY
    segment,
    CASE
        WHEN activity_date BETWEEN '2026-08-03' AND '2026-08-09' THEN '1) Week before (3-9 Aug)'
        WHEN activity_date BETWEEN '2026-08-10' AND '2026-08-16' THEN '2) Week after  (10-16 Aug)'
        WHEN activity_date BETWEEN '2026-08-17' AND '2026-08-23' THEN '3) Week 3      (17-23 Aug)'
    END
ORDER BY segment, week_bucket;

-- Expected shape: 'All' drops sharply after 10 Aug (reproducing the reported
-- 35% -> ~28% cliff); 'External' stays essentially flat across all three
-- weeks; 'Internal' shows DAU falling to zero after 10 Aug while its MAU
-- decays only slowly, confirming the mechanism.
