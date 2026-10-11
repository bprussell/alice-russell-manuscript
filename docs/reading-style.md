# Reading-edition style guide (Phase 3)

How the verbatim archival transcripts (`transcript/page-NNN.md`) are
converted into the reading text (`book/`). Goal, per PLAN.md: a lightly
edited text — obvious typos corrected and pencil corrections applied, with
**no substantive changes to meaning** and the author's voice preserved.

## Output structure

- One Markdown file per chapter: `book/book-1/chapter-NN.md` (30 chapters)
  and `book/book-2/chapter-NN.md` (27 chapters), `NN` zero-padded.
- Each file starts `# Chapter N` (arabic chapter heading text "Chapter One"?
  No — use the manuscript's roman numerals: `# Chapter I`).
- Flowing paragraphs separated by blank lines; no leading indents; original
  line breaks are NOT preserved (rejoin hyphenated words silently).
- Typed underlines `<u>word</u>` become italics `*word*`.
- Verse quotations (e.g. the Rubaiyat quatrains) keep their indented
  line-by-line shape as Markdown block quotes.
- Chapter-internal section flourishes (rows of dashes) become a centered
  `* * *` separator.

## What is dropped

- The per-page "Submitted by:" blocks, typed page numbers, and page 1's
  "100,000 words" declaration.
- Book I's closing instruction "TURN THIS BOOK UPSIDE DOWN AND BEGIN ON
  FIRST PAGE" (a physical-volume artifact; the foreword will mention it).
- All ⟦…⟧ markers, resolved per the rules below.

## Marker resolution

- `x⟦pencil-delete⟧` — the struck text `x` is removed.
- `⟦pencil-insert: y⟧` — `y` is inserted.
- `word⟦pencil: replacement⟧` — the pencil `replacement` is used.
- `⟦strikeover: …⟧` — the strikeover marker describes a self-correction
  already resolved in the surrounding text; drop the marker, keep the text.
  Where the marker records struck text (e.g. `info⟦strikeover⟧`,
  `⟦strikeover: the⟧`), the struck text is removed.
- `⟦unclear: w⟧` — use `w` (it is the settled best reading).
- `⟦illegible⟧` — nothing recoverable; smooth the sentence only if a
  READING LAYER note says how, otherwise omit the unreadable fragment.
- `⟦hyphen⟧` — rejoin the word across the line break.
- `⟦pencil-note: …⟧` — editorial/marginal note, not text; drop and log.

## READING LAYER notes override everything

Some transcript files carry explicit "READING LAYER" notes from the
physical-page review (e.g. page 60 "seen" → "scene,"; page 126 restoring
the overlapped locket question; page 185 "not all all" → "not at all";
page 248 omitting struck "info"). Apply them exactly and log them.

## Correction policy

**Fix (and log):**
- Unintentional misspellings anywhere: "surprize"→"surprise",
  "begger"→"beggar", "decended"→"descended", "grabed"→"grabbed",
  "quized"→"quizzed", "Chaper"→"Chapter", "mamager"→"manager", etc.
- Typing slips: run-together words ("hecould", "was,became", "tonehad"),
  doubled words ("all all" per its note), dropped or doubled letters
  ("swu g" is "swung"; "you g"→"young"; "enourh"→"enough"), the "8" typed
  for an apostrophe ("I8ll"→"I'll"), stray periods/commas mid-sentence.
- Missing possessive apostrophes: "Aunt Kates"→"Aunt Kate's",
  "loves chisel"→"love's chisel", "this girls"→"this girl's".
- Unbalanced or mismatched quotation marks: repair minimally so every
  speech opens and closes correctly; single-quote dialogue resumptions
  become standard double quotes.
- Name normalization: **"Johnie" everywhere** (see book/edits.md);
  "Parepa-Roza"/"-Rosa" variation: normalize to "Parepa-Roza" (the
  dominant form). "Frances" for the male character even where typed
  "Francis"/"Francex".
- Word-usage slips explicitly confirmed during review (e.g. "correct Aunt
  Kate"→"corrected", "know better"→"knew better" where the review notes
  flagged Phase 1 restorations of authorial slips — the reading layer
  takes the standard form).

**Keep (do NOT "fix"):**
- Dialect and voice, especially in dialogue: "ain't", "comin'", "Dish is
  my sweetheart", "sweet kish", stuttered "k-k-kicked", "drug him from
  the house", "most noon"/"most thirty years" (for "almost"), "use to",
  "sociables", "Ye Gods!", pet names and exclamations.
- "gray/grey" variation. (Split and hyphenated compounds such as
  "never-the-less", "bath room", "street car" are no longer kept —
  they take modern closed spelling; see "Spelling of compounds
  modernized" in book/edits.md for the rule and its exceptions.)
- Her sentence rhythms, comma splices, and grammatical quirks in
  dialogue ("was you", "them things", "he don't", singular/plural slips).
  (Subject–verb agreement slips in *narration* are corrected — see
  "Subject–verb agreement corrected in narration" in book/edits.md.)
- When genuinely unsure whether something is voice or slip: keep it as
  written and log it as "kept".

**Typography (global rules, not logged per instance):**
- Quotation marks stay straight in `book/`; they are curled at build
  time by `print/smartquotes.py`. A double quote nested inside dialogue
  (she typed straight doubles for both levels) is printed as single
  quotes — "...finding the 'missing link' in their chain..." — and
  leading apostrophes for dropped letters ('phone, 'Twas, 'bout) curl as
  apostrophes, not opening quotes.
- Collapse double/triple spaces; standard single space after punctuation.
- Dashes typed as " - ", " -- ", "---" used parenthetically become
  em dashes (—); trailing dash-flourishes at speech ends become an em
  dash.
- Straight quotes may remain straight (typesetting phase will smart-quote).
- Terminal commas and periods go INSIDE closing quotation marks (standard
  American style) even where the typescript places them outside; add the
  conventional comma before a dialogue attribution where the typescript
  omits it ("...child," her mother would say).
- The typewriter-composed exclamation mark (apostrophe over/beside a
  period, e.g. `Oh'.`) is rendered as "!".

## Logging

Every non-global correction is logged in `book/edits.md` under a
`### Book N, Chapter M` heading, one compact line each:
`- p42 "threwgh" → "threw"` — with an optional short reason when it isn't
obvious. Recurring fixes within a chapter may be logged once with
"(and passim)". Judgment calls the editor wasn't sure about get a `?` flag
for review.

## Chapter boundaries (from the chapter map)

Book I: I:1, II:8, III:22, IV:24(mid-page, at the pencil "Chap. 4." mark
after "child belonged to her already."), V:31, VI:33, VII:44, VIII:49,
IX:54, X:59, XI:64, XII:65, XIII:68, XIV:70, XV:75, XVI:78, XVII:83,
XVIII:86, XIX:90, XX:93, XXI:99, XXII:114, XXIII:120, XXIV:125, XXV:134,
XXVI:141, XXVII:147, XXVIII:152, XXIX:154, XXX:157 (ends p164).

Book II: I:165, II:172, III:174, IV:179, V:185, VI:187, VII:188, VIII:190,
IX:194, X:197, XI:201, XII:205, XIII:209, XIV:214, XV:219, XVI:223,
XVII:228, XVIII:232, XIX:234, XX:239, XXI:246, XXII:252, XXIII:255,
XXIV:262, XXV:271, XXVI:285, XXVII:287 (ends p288 with THE END).
