# Digitization Pipeline Plan

The manuscript: ~289 typewritten pages from the early 1900s, photographed one
page per photo. The pages contain typos, handwritten pencil corrections,
underlined words, and a couple of pages with table structures.

## Phase 0 — Ingest the photos

Photos go in `pages/originals/`, committed to this repo. Claude (running in a
cloud container with this repo cloned) reads the images directly with its own
vision — no external OCR service. This is important for this material:
traditional OCR handles clean typewriter text poorly once pencil marginalia,
fading, and strike-overs are involved, while a vision model can transcribe the
typed layer and the pencil layer separately in one look.

### How to upload (pick one)

**Option A — git push from your computer (recommended, one shot):**

```bash
git clone https://github.com/bprussell/book-digitizer.git
cd book-digitizer
git checkout claude/manuscript-digitization-pipeline-tj8dnv
mkdir -p pages/originals
cp /path/to/your/photos/* pages/originals/
git add pages && git commit -m "Add manuscript page photos"
git push
```

**Option B — GitHub web UI:** navigate to the repo on github.com, switch to
this branch, and drag-and-drop the photos into `pages/originals/`. The web UI
caps uploads at ~100 files and 25 MB per file, so 289 pages takes about three
batches.

### Upload notes

- **Filenames:** anything is fine as long as alphabetical order = page order
  (e.g. `IMG_2041.jpg`, `IMG_2042.jpg`, …). Claude will normalize them to
  `page-001.jpg` … `page-289.jpg` after upload. If your photos are *not* in
  page order alphabetically, rename them yourself or note the correct order.
- **Resolution:** don't over-compress. Typewriter text transcribes well at
  ~2000–3000 px on the long edge. Straight-off-the-phone photos are fine.
- **Size:** if the full set exceeds ~1.5 GB, downscale first (e.g. with
  ImageMagick: `mogrify -resize 3000x3000\> -quality 85 *.jpg`). GitHub
  tolerates repos of this size but stays snappy under ~1 GB.
- If a page photo is blurry or cut off, it's much cheaper to reshoot it now
  than to discover it during transcription — but the verification phase will
  also flag unreadable pages.

## Phase 1 — Verbatim transcription (archival layer)

One Markdown file per page in `transcript/` (`page-001.md` …), each containing:

- YAML front matter: page number, source image, flags (`has_table`,
  `has_pencil`, `illegible_spots`, `needs_review`).
- The page text **exactly as typed** — typos, misspellings, odd punctuation
  and all. Original line breaks are preserved so the transcript can be
  proofread line-by-line against the photo.
- Inline annotations for everything that isn't plain typed text (pencil
  corrections, underlines, illegible spots, tables). The full convention set
  is in [docs/transcription-format.md](docs/transcription-format.md).

Work proceeds in batches of ~25–40 pages per session, tracked in the README
status checklist, so progress survives across sessions and nothing is
transcribed twice.

## Phase 2 — Verification pass

Every page gets a second, independent look: a fresh agent compares the
transcript against the photo and flags discrepancies. Output is a review
queue (`transcript/REVIEW.md`) listing:

- transcription mismatches (fixed directly),
- genuinely ambiguous spots — faded text, unclear pencil marks — that need
  a human judgment call. These get resolved with you before Phase 3.

## Phase 3 — Edited reading text

The verbatim transcripts are stitched into continuous chapters in `book/`,
applying exactly two kinds of changes:

1. **Pencil corrections** — the author's own edits, applied as she indicated.
2. **Obvious mechanical typos** — transposed letters, doubled words, clear
   misspellings of common words.

**Not** changed: period spelling and usage, grammar quirks, word choice,
punctuation style, or anything where the "correction" would alter voice or
meaning. When in doubt, the typed text stands.

Every single change is logged in `book/edits.md` as
`page → original → corrected → reason`, so the editing is fully auditable
against the archival layer and reversible.

## Phase 4 — Typesetting and print

- Typeset with Pandoc + LaTeX (or Typst) from the `book/` chapters into a
  print-ready PDF: trim size around 5.5″×8.5″ or 6″×9″, a period-appropriate
  serif face, title page, and optionally a short foreword about the author
  and facsimile plates of a few original pages (a nice touch for a gift —
  showing the pencil corrections in her own hand).
- Underlined words in the manuscript are rendered as italics (the standard
  print convention that typewriter underlining stood in for), unless you
  prefer literal underlines.
- Output goes to `print/` along with the sources, sized to the spec of the
  chosen print-on-demand service (Lulu and Blurb are the usual picks for a
  small hardcover run; both accept a PDF).
- An EPUB is generated from the same sources for free.

## Decision points for you (defaults in bold)

These don't block the upload or Phase 1 — the archival layer captures
everything either way — but they shape Phases 3–4:

1. Underlines in print: **italics** vs. literal underline.
2. Preserve original page breaks in the printed book, or **reflow naturally**?
3. Include a foreword / "about this edition" note describing the manuscript
   and editing approach? (**yes, drafted for your review**)
4. Include facsimile plates of selected original pages? (**yes, a few**)
5. Trim size / hardcover vs. paperback — decide when we get to Phase 4.
