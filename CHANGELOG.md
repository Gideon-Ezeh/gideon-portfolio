# Changelog

A running log of what's been built/changed on this site. Keep this updated when you (or Claude) make changes, so future sessions know what's already been done and why.

## 2026-08-17 (latest) — Newest-content-on-top convention; reordered project grid

**Why:** Gideon wants clients to see the most recent work first without scrolling — new projects/research/trainings should always be added at the top of their list, not the bottom. This applies to every future addition, not just this one.

**Changed:** moved the Zephyr Bank project card to the top of the `#projects` grid in `index.html` (was last of 4, now first). Documented the convention in `README.md` under a new "Conventions" section, and saved it as a persistent memory (`feedback_newest-content-on-top.md`) so future sessions apply it automatically without being re-told.

**How to apply going forward:** when adding a new project card to `index.html`, a new featured write-up to `research.html`, or a new featured training to `trainings.html`, insert it as the *first* child in its container.

## 2026-08-17 (latest) — Added Zephyr Bank case study as 4th project; updated experience & phone

**Why:** Gideon published a new Medium article ("The Numbers Looked Fine. That Was The Problem") about a Power BI/Excel transaction-health dashboard he built for a fictional UK neobank (Zephyr Bank) as a data analytics challenge, and wanted it added as a 4th portfolio project tagged Finance + Business. He also asked for years-of-experience and phone number updates.

**Added `projects/zephyr-bank-dashboard.html`:** full case study built from the Medium article's actual text (paraphrased where natural, key stats kept exact) — Brief, a 3-stat "what the headline numbers hide" grid, then one section per dashboard page (Executive Summary, Temporal Trends, Customer & Segment, Transaction & Merchant, Fee Revenue & Leakage) each paired with its real screenshot, plus the "What I'd action from this" list from the original post. CTA links to the live Medium article.

**Images:** downloaded all 6 images directly from the Medium post's `miro.medium.com` CDN (`zephyr-cover.png` + 5 dashboard-page screenshots) via `curl` at `resize:fit:1400` for quality, saved to `assets/img/`.

**Home page (`index.html`):** added the 4th project card (`data-categories="finance business"`) to the `#projects` grid; updated hero stats "Years experience" 3+ → 4+ and "Featured projects" 3 → 4; updated hero-lead copy 3+ → 4+ years; updated Contact section phone number to +234 810 986 4035 (reformatted from the local `08109864035` the user gave, to match the site's existing `+234 xxx xxx xxxx` convention — same digits, international format).

**Note on the browser preview tool:** local `file://` verification for nested pages in this session sometimes renders as a `data:` URI snapshot instead of a live file load, which breaks relative-path checks (images/CSS) done via `fetch()` in that snapshot — this is a quirk of the preview tool itself, not a site bug. When it happens, verify by reading the decoded `document.location.href` (still contains full accurate HTML) or just check the live Netlify deploy instead.

## 2026-07-24 (latest) — Added FMBEP Power BI workshop to Trainings page

**Why:** Gideon shared a second real credential — a hands-on Power BI workshop he co-facilitated for Nigeria's Federal Ministry of Budget and Economic Planning (FMBEP), in collaboration with UNFPA — sourced from his own LinkedIn post, with 4 event photos.

**Changed on `trainings.html`:** added a "Featured Training" section (same pattern as the C19RM feature on `research.html`) between "What I teach" and "Who it's for" — meta grid (client/partner/co-facilitator/format/focus), a narrative built from his LinkedIn post (paraphrased, not verbatim), a pull-quote ("Aggregate data lies..."), and a 4-photo gallery. Header tags gained "DAX" and "Facilitation"; lead paragraph and meta description now reference this engagement directly.

**Assets added:** `assets/img/fmbep-dashboard-screen.jpg`, `fmbep-group-session.jpg`, `fmbep-facilitating.jpg`, `fmbep-workshop-banner.jpg`.

**Note:** unlike the C19RM feature, this one has no numeric results-grid — no hard stats were given (e.g. participant count), so the proof here is the pull-quote and the participant anecdote instead of invented numbers.

## 2026-07-24 (latest) — Replaced Research page project grid with the C19RM flagship project

**Why:** Gideon shared a real, substantial credential — Research Data Manager & HEPR Pillar Co-Lead on the Nigeria C19RM Impact Evaluation (Global Fund / Jhpiego Nigeria / NACA / NTBLCP), sourced from his own LinkedIn post — and asked for the 3-project grid on `research.html` to be replaced with it, plus 4 real event photos he attached.

**Changed on `research.html`:** removed the grid linking to the 3 home-page case studies; replaced with a full featured write-up of the C19RM evaluation — meta grid (funder/implementer/partners/role/duration), "The Mandate" and "My Role & Approach" narrative sections (built from his LinkedIn post, paraphrased/professionalized, not fabricated), a pull-quote, a results stat row (8 weeks protocol-to-briefing, 6 geopolitical zones, 11 domain datasets — all real figures from his account), and a 4-photo gallery. Header tag pills gained "Monitoring & Evaluation" and "Kobo Toolbox" since this project evidences those skills.

**Assets added:** `assets/img/c19rm-portrait-full.jpg`, `c19rm-portrait-closeup.jpg`, `c19rm-group-1.jpg`, `c19rm-group-2.jpg` — copied from the user's Downloads folder (originals were pasted into chat).

**New CSS:** `.photo-gallery` (responsive image grid, 4-col desktop / 2-col mobile) and `.pull-quote` (gradient left-border blockquote) added to `style.css`, reusable for future case studies.


## 2026-07-24 (later) — Added Research and Trainings pages, project category filter

**Why:** Gideon does research projects and facilitates data trainings alongside client analytics work, and wanted those surfaced as their own nav destinations, plus a way to browse projects by industry as the project list grows.

**Added:**
- `research.html` and `trainings.html` — new top-level pages (not anchors), linked from the nav on every page (`index.html` and all `projects/*.html`). Content is built only from facts already established elsewhere on the site (the "open to research/tutoring" line from Contact, and the real methodology evidenced by the 3 existing case studies) — no invented past research projects or training curricula/pricing, since none were provided. **Follow-up:** expand these with real specifics (past research topics, training formats/pricing, testimonials) when available.
- Research page reuses the 3 existing case studies, framed accurately as self-directed research projects (which they are).
- Project category filter on the home `#projects` section: pill-button bar with "All" plus 15 categories (Business, Healthcare, Travel, Retail, Human Resources, Finance, Sports, Transportation, Geospatial, Entertainment, Food & Beverages, Survey, Hospitality, Environment, Time series). Implemented via `data-categories` attributes on each `.project-card` and filter logic in `main.js`; categories with zero current matches show a friendly empty state instead of a blank grid. **Assumed tags** (confirm/adjust): Coffee Taste Test → Food & Beverages, Survey, Business; UK Train Rides → Transportation, Business; Himalayan Archives → Travel, Sports, Time series.

**How to apply going forward:** every new project card added to `#projects` needs a `data-categories` attribute (space-separated slugs, e.g. `data-categories="finance business"`) or it won't appear under any filter except "All".

## 2026-07-24 — Fixed contact form false "success" message

**Why:** After going live on Netlify, the contact form showed "Thanks! Your message has been sent" but no submission actually reached Netlify's Forms dashboard. Debugging showed the form's POST to `/` was returning a 404 — Netlify's form-detection bot hadn't picked up the `contact` form (its per-site "Form detection" setting was off despite the account-level Forms feature being enabled). Fixed via the Netlify project API (`update-forms` → enabled) and confirmed the HTML markup itself was already correct (`data-netlify="true"`, matching `form-name` hidden field).

**Real bug fixed regardless:** `assets/js/main.js`'s submit handler only checked that the `fetch()` call completed, not whether the response was actually a success (`response.ok`) — so it showed the success message even on a 404/500. Now throws (triggering the error message) on any non-2xx response. This matters any time the form endpoint misbehaves, not just for this one incident.

**How to apply going forward:** if the form ever silently "succeeds" locally but nothing shows up in Netlify's Forms dashboard, check the site's Form detection setting and confirm a fresh deploy has run since the form's HTML last changed — detection re-scans on every deploy.

## 2026-07-23 (later) — Merged in real content, restyled with Auros design system, prepped for Git

**Why:** The first build used entirely placeholder content. The user has a real, already-live portfolio (`GideonWebsite`, an HTML5 UP "Editorial" template) with genuine bio, projects, and contact info, plus a style reference (`DESIGN.md`, an "Auros" dark-teal fintech style) they wanted applied instead of the original teal/near-black scheme. They also want the site on GitHub, deploying to Netlify via CI rather than drag-and-drop.

**Content merged in from `GideonWebsite`:**
- Real name/title (Gideon Ezeh, Data/Business Analyst), real bio paragraph, real skill descriptions (Analytical Skills, Communication, Problem-Solving, Collaboration)
- Real contact info: `ezehgideon92@gmail.com`, `+234 817 628 3663`, Abuja, Nigeria
- Real social links: Twitter/X, Facebook, YouTube, LinkedIn
- Real photo (`assets/img/me.jpg`) used in the hero instead of a decorative SVG
- Resume link points to the real Google Drive link from the old site (flagged in README as a folder link, not ideal — should be swapped for a direct file link)

**Projects replaced:** the 4 fictional case studies were deleted. In their place, 3 real projects were rebuilt as full case-study pages (`projects/coffee-taste-test.html`, `uk-train-rides.html`, `himalayan-archives.html`), each also linking out to its original Medium article. Content for each was pulled from the actual published Medium posts (fetched and summarized, not invented) — stats like the 87% on-time performance, 32K tickets/$742K revenue, 77% of peaks climbed, etc. are real figures from those articles, not placeholders.

**Testimonials section removed.** The original build had 3 invented placeholder testimonials — those were cut entirely rather than carried over, since fabricated client quotes on a site now going live under a real person's name isn't appropriate. Re-add a real testimonials section once genuine client feedback exists.

**Design system replaced** per `DESIGN.md` (Auros style reference): dark teal "abyss" canvas (`#012624`) instead of near-black, bioluminescent teal→pink gradient reserved for the primary CTA and stat numbers, no drop shadows (surface-color depth instead: abyss → deep → kelp), 16px card / 6px button radius, uppercase-tracked nav and eyebrow labels. Display font switched to Plus Jakarta Sans (medium-weight only, matching the style guide's "no bold, no light" heading rule) loaded via Google Fonts; body copy uses Inter.

**Verified working:** all real images/pages resolve (200 status), responsive grid breakpoints (hero 2-col → 1-col, projects 3-col → 1-col) confirmed via computed styles at 1280px and 375px, no console errors on home page or case-study pages.

**Not yet done:** git init / GitHub push — in progress, see chat for the exact commands used.

---

## 2026-07-23 — Initial build

**Goal:** static portfolio site for a data analyst, built to win freelance clients.

**Stack decision:** plain HTML/CSS/JS, no build step, no framework — easiest to maintain and deploy for free on Netlify.

**Structure created:**
- `index.html` — home page: nav, hero, about/skills, featured project cards, testimonials, contact form, footer
- Case-study pages under `projects/` — same template pattern (Challenge/Objective → Approach → Results/Findings → CTA)
- `assets/css/style.css` — single shared stylesheet with CSS variables, mobile-first responsive breakpoints at 900px and 720px
- `assets/js/main.js` — mobile nav toggle, active-nav-link highlighting on scroll (IntersectionObserver), reveal-on-scroll animation, contact form submit handling
- `README.md` — user-facing instructions: what to customize, how the contact form works, how to deploy to Netlify

**Contact form:** uses Netlify Forms (`data-netlify="true"` + hidden `form-name` field + honeypot field for spam). No backend code — submissions appear in the Netlify dashboard once deployed. Locally (opened via `file://`), the JS shows a message explaining it only works once deployed, instead of silently failing.

**Verified working:** responsive layout at desktop/mobile widths, mobile nav toggle, project card links, contact form local-vs-deployed behavior, no console errors.

---

<!-- Add new entries above this line, newest first, dated, with what changed and why. -->
