# Gideon Ezeh — Data Analyst Portfolio

A static HTML/CSS/JS portfolio site for Gideon Ezeh, Data/Business Analyst. No build step, no framework — open `index.html` or deploy the folder as-is.

## What's here

```
index.html                              Home page (hero, about, skills, projects, contact)
projects/coffee-taste-test.html         Case study — Great American Coffee Taste Test
projects/uk-train-rides.html            Case study — UK Train Rides (National Rail)
projects/himalayan-archives.html        Case study — The Himalayan Archives
assets/css/style.css                    All styling (Auros-derived dark teal theme)
assets/js/main.js                       Mobile nav, scroll effects, contact form handling
assets/img/                             Real photo + real project thumbnails
```

All content is real — pulled from the existing `GideonWebsite` HTML5 UP template and the three published Medium case studies. Nothing on this site is a placeholder.

## Design

The visual style follows the Auros style reference (`DESIGN.md` in Downloads): a dark teal "abyss" canvas (`#012624`), a bioluminescent teal→pink gradient reserved for the primary CTA button and stat highlights, no drop shadows (depth comes from surface color shifts: abyss → deep → kelp), 16px card radius / 6px button radius, and uppercase tracked labels for nav/eyebrows. Display font is Plus Jakarta Sans (medium weight only, per the style guide's "no bold, no light" rule for headings); body/UI text is Inter. Both are loaded from Google Fonts in each page's `<head>`.

## Editing content

Everything is plain HTML — open any `.html` file in a text editor. Styling lives in one shared file (`assets/css/style.css`).

To add a new project: copy one of the files in `projects/` as a starting template, update the meta info and sections, add image(s) to `assets/img/`, and add a matching project card to the `#projects` grid in `index.html` — **at the top of the grid**, not the bottom (see Conventions below).

## Conventions

- **Newest goes on top.** Any time a new project, research write-up, or training is added, it goes at the *top* of its list/grid (`#projects` in `index.html`, the featured section in `research.html`, the featured section in `trainings.html`) — not appended at the bottom. Clients should see the most recent work first without scrolling.

## Known follow-ups

- **`assets/img/me.jpg` is ~1.7MB** — worth compressing (e.g. via [squoosh.app](https://squoosh.app)) before final deploy so the hero loads fast on mobile.
- **Resume link** currently points to a Google Drive *folder* (`#about` → Resume card), not a single PDF file — consider sharing a direct file link instead so visitors land on the resume itself, not a folder listing.
- **No testimonials section** — intentionally left out since there's no real client feedback yet. Add one back in once you have a few real quotes; don't fabricate placeholder ones on a live personal site.

## Contact form

Uses **Netlify Forms** — `data-netlify="true"` + hidden `form-name` field, already wired up, no backend needed. Submissions appear under your site's **Forms** tab in the Netlify dashboard once deployed. It intentionally does nothing but show a message when opened locally via `file://`.

## Deploying

This repo is set up to deploy from **GitHub → Netlify** (continuous deployment) rather than drag-and-drop, so every `git push` to `main` auto-publishes. See the setup steps shared in chat, or:

1. Push this repo to GitHub (`git remote add origin <url>`, `git push -u origin main`)
2. In Netlify: "Import an existing project" → connect the GitHub repo → leave build command blank, publish directory `/`
3. Every future push to `main` deploys automatically
