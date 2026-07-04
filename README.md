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
pages/originals/   Photos of the manuscript pages (page-001.jpg … page-289.jpg)
transcript/        Verbatim per-page transcriptions (archival layer)
book/              Edited, continuous text organized by chapter (reading layer)
book/edits.md      Log of every correction made between the two layers
print/             Typesetting sources and the final print-ready PDF
docs/              Project documentation and conventions
```

See [PLAN.md](PLAN.md) for the full pipeline plan and
[docs/transcription-format.md](docs/transcription-format.md) for the
annotation conventions used in the verbatim transcripts.

## Status

- [ ] Phase 0 — Photos uploaded and normalized (pilot: 2/289)
- [ ] Phase 1 — Verbatim transcription (pilot: 2/289 pages)
- [ ] Phase 2 — Verification pass
- [ ] Phase 3 — Edited reading text
- [ ] Phase 4 — Typesetting and print PDF
