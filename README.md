# Book Digitizer

Digitizing a typewritten manuscript from the early 1900s — a book written by
the author's great-grandmother — into an archival transcription and a
print-ready edition to be given as a gift.

## Goals

1. **Archival layer** — a faithful, verbatim transcription of every page:
   typos preserved, pencil corrections recorded as annotations, underlines and
   tables captured.
2. **Reading layer** — a lightly edited text: obvious typos corrected and
   pencil corrections applied, with **no substantive changes to meaning**.
3. **Print layer** — a typeset, print-ready PDF suitable for a
   print-on-demand service (Lulu, Blurb, KDP), plus an EPUB as a bonus.

## Repository layout

```
pages/originals/   Photos of the manuscript pages (page-001.jpg … page-288.jpg)
pages/box-photo.jpg  Keepsake photo of the manuscript in its box
transcript/        Verbatim per-page transcriptions (archival layer)
transcript/REVIEW.md  Pages needing a human look at the physical manuscript
book/              Edited, continuous text organized by chapter (reading layer)
book/edits.md      Log of every correction made between the two layers
print/             Typesetting sources and the final print-ready PDF
docs/              Project documentation and conventions
```

See [PLAN.md](PLAN.md) for the full pipeline plan and
[docs/transcription-format.md](docs/transcription-format.md) for the
annotation conventions used in the verbatim transcripts.

## Status

- [x] Phase 0 — Photos uploaded and normalized (288 pages + box photo,
      imported from a shared Google Photos album; all pages
      orientation-verified page-by-page)
- [x] Phase 1 — Verbatim transcription (288/288 pages)
- [x] Phase 2 — Verification pass (288/288 pages verified against source
      photos. ~50 pages retain a genuinely unresolved ambiguity that only
      the physical manuscript can settle — see transcript/REVIEW.md)
- [ ] Phase 3 — Edited reading text
- [ ] Phase 4 — Typesetting and print PDF
