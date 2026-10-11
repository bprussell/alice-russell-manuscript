#!/usr/bin/env bash
# Builds the reader's-proof EPUB from the reading text in book/.
# Usage: print/epub/build.sh   (set PANDOC=/path/to/pandoc if not on PATH)
set -euo pipefail
cd "$(dirname "$0")/../.."
PANDOC="${PANDOC:-pandoc}"
out="print/proof/readers-proof.epub"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

part() {  # $1 = book dir, $2 = part heading, $3 = book title
  printf '# %s: *%s*\n\n' "$2" "$3"
  for f in "$1"/chapter-*.md; do
    sed 's/^# /## /' "$f"; printf '\n\n'
  done
}
part book/book-1 "Book One" "The Locket of Family Secrets" > "$tmp/book-1.md"
part book/book-2 "Book Two" "The Heir of the Broken Chain" > "$tmp/book-2.md"

"$PANDOC" print/epub/metadata.yaml print/epub/proof-note.md \
  "$tmp/book-1.md" "$tmp/book-2.md" \
  --from markdown --to epub3 --split-level=2 --toc --toc-depth=2 \
  --css print/epub/epub.css -o "$out"
echo "Wrote $out"
