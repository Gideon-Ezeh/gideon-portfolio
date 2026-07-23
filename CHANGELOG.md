# Changelog

A running log of what's been built/changed on this site. Keep this updated when you (or Claude) make changes, so future sessions know what's already been done and why.

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
