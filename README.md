# The Locket of Family Secrets & The Heir of the Broken Chain

**A novel in two books by Alice Reynolds Russell of Edelstein, Illinois,
written in the early twentieth century and preserved by her family as a
288-page typescript.**

This repository is the permanent record behind the family's printed
edition of her book. It holds everything needed to check the printed text
against what she actually typed:

| What | Where |
|---|---|
| Photographs of every original page | [`pages/originals/`](pages/originals/) (`page-001.jpg` … `page-288.jpg`), and the manuscript in its box: [`pages/box-photo.jpg`](pages/box-photo.jpg) |
| Word-for-word transcription of each page — her typing, strikeovers and pencil corrections exactly as they appear | [`transcript/`](transcript/) |
| The edited reading text, chapter by chapter | [`book/book-1/`](book/book-1/), [`book/book-2/`](book/book-2/) |
| A log of every change made between her pages and the printed text, and why | [`book/edits.md`](book/edits.md) |
| What we know about the manuscript and the author | [`docs/manuscript-notes.md`](docs/manuscript-notes.md) |
| Typesetting sources, fonts and the print and e-book files | [`print/`](print/) |

Book One was titled by the family (the original title was erased; only
"OF" and "SECRETS" survive). Book Two's title was recovered from the
impression the erased type left in the paper. See
[`docs/manuscript-notes.md`](docs/manuscript-notes.md).

## How the text was prepared

1. **Transcription:** every page was transcribed exactly as typed, with
   pencil marks, strikeovers and underlines recorded as annotations (see
   [`docs/transcription-format.md`](docs/transcription-format.md)), then
   checked a second time against the photograph.
2. **Reading text:** typing slips corrected and her own pencil corrections
   applied; spelling, capitalization and punctuation brought to modern
   American usage; a few grammatical slips in the narration set right;
   unspoken thoughts set in italics. Her words, phrasing and dialogue are
   her own. Every change is listed in [`book/edits.md`](book/edits.md).
3. **Print edition:** typeset in Sorts Mill Goudy at 6″ × 9″ (see
   [`print/book/`](print/book/)); an EPUB is built from the same text.

The working plan for the project is in [PLAN.md](PLAN.md).

## Status

- [x] Phase 0 — Photos uploaded and normalized (288 pages + box photo,
      imported from a shared Google Photos album; all pages
      orientation-verified page-by-page)
- [x] Phase 1 — Verbatim transcription (288/288 pages)
- [x] Phase 2 — Verification pass (288/288 pages verified against source
      photos, and the ~50-item review queue subsequently worked to zero in
      a physical-page review with the family — see transcript/REVIEW.md.
      The two erased book titles are permanently unrecoverable; the
      reading edition will carry editor-composed titles, disclosed in the
      foreword — see book/edits.md)
- [x] Phase 3 — Edited reading text (all 57 chapters — Book I: 30, Book II:
      27 — in book/book-1/ and book/book-2/, with every correction logged
      in book/edits.md; all 69 open judgment calls since ruled on by the
      family, and split/hyphenated compounds modernized — see its
      "Resolved REVIEW flags" and "Global decisions" sections)
- [x] Phase 3.5 — Reader's proof: full read-through of the EPUB
      (print/proof/readers-proof.epub, built by print/epub/build.sh),
      completed by the family. Changes from the read-through — spelling,
      capitalization, comma and grammar passes, italics for thoughts, and
      individual fixes — are logged in book/edits.md
- [ ] Phase 4 — Typesetting and print PDF
