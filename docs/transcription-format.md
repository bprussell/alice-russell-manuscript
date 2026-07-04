# Transcription Format Conventions

Each page in `transcript/` is a Markdown file with YAML front matter followed
by the verbatim page text. The guiding rule: **the typed layer is sacred** —
it is recorded exactly as it appears, and everything else (pencil, underlines,
damage, uncertainty) is layered on top with explicit markers.

## File template

```markdown
---
page: 17
image: pages/originals/page-017.jpg
has_pencil: true
has_table: false
illegible_spots: 0
needs_review: false
---

The text of the page exactly as typed, with original line
breaks preserved, incuding any typos just as they appear
on the page.
```

## Markers

All markers use `⟦…⟧` brackets, which cannot be confused with anything a
1900s typewriter produced.

| Marker | Meaning |
|---|---|
| `word ⟦pencil: correction⟧` | Pencil correction: the typed text stands as typed; the pencil edit is recorded immediately after the text it applies to. |
| `⟦pencil-insert: new text⟧` | Pencil inserts words with no typed counterpart (caret insertions, marginal additions). Placed at the insertion point. |
| `⟦pencil-delete⟧` after struck text | Pencil strikes through typed text without replacement. |
| `⟦pencil-note: …⟧` | Marginal note that is commentary rather than a correction. |
| `<u>underlined text</u>` | Typed underline (typewriter underscore or ruled by hand under typed text). |
| `⟦strikeover: xed-out text⟧` | Text struck out *by the typewriter* (xxxx-ed over) — distinct from pencil deletion. |
| `⟦illegible⟧` | Text that cannot be read at all. |
| `⟦unclear: best guess⟧` | Legible enough for a best guess, flagged for the verification pass. |
| `⟦hyphen⟧` at end of line | End-of-line hyphenation in the original (so the reflowed reading text knows to rejoin the word). |

## Examples

Typed typo left as-is, with the author's pencil fix recorded:

```
She walked slowly twoard ⟦pencil: toward⟧ the old farmhouse
```

Pencil insertion between typed words:

```
He was ⟦pencil-insert: very⟧ tired that evening
```

Typed underline (rendered as italics in the printed book):

```
It was the <u>Mauretania</u> that brought them across
```

## Tables

Pages with tabular structure are transcribed as Markdown tables, preserving
the column headers and cell text verbatim. If the original alignment carries
meaning that a Markdown table loses, a fenced code block with spatial layout
is used instead, and `has_table: true` is set either way.

## Line breaks and hyphenation

Original line breaks are preserved in the transcript (they make
proofreading against the photo vastly easier). Words hyphenated across a
line break keep the hyphen plus a `⟦hyphen⟧` marker. Paragraph breaks are
blank lines, as in standard Markdown. Page-level features like page numbers
typed on the page are recorded where they appear.
