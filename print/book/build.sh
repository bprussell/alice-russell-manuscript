#!/usr/bin/env bash
# Builds the print-ready interior PDF from book/ (Phase 4).
# Needs pandoc and the typst Python package; set PANDOC / PYTHONPATH if they
# are not on the default paths. Output: print/book/interior.pdf
# Optional: FONT="Libre Caslon Text" FONT_SIZE=10 (font files in print/fonts
# or in FONT_DIRS), OUT=path.pdf
set -euo pipefail
cd "$(dirname "$0")/../.."
PANDOC="${PANDOC:-pandoc}"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

typst_raw() { printf '\n```{=typst}\n%s\n```\n\n' "$1"; }
{
  # Front-matter section: the foreword (HTML comments stripped).
  typst_raw '#section[Foreword]'
  sed '/<!--/,/-->/d; /^# Foreword/d; s/^## /### /' print/book/foreword.md | python3 print/smartquotes.py
  typst_raw '#pagebreak(to: "odd", weak: true)
#set page(numbering: "1")
#counter(page).update(1)'
  typst_raw '#part[One][The Locket of Family Secrets]'
  for f in book/book-1/chapter-*.md; do
    sed 's/^# /## /' "$f" | python3 print/smartquotes.py; printf '\n\n'
  done
  typst_raw '#part[Two][The Heir of the Broken Chain]'
  for f in book/book-2/chapter-*.md; do
    sed 's/^# /## /' "$f" | python3 print/smartquotes.py; printf '\n\n'
  done
  if [ -f print/book/afterword.md ]; then
    typst_raw '#section[Afterword]'
    sed '/<!--/,/-->/d; /^# Afterword/d; s/^## /### /' print/book/afterword.md | python3 print/smartquotes.py
  fi
} > "$tmp/body.md"

"$PANDOC" "$tmp/body.md" --from markdown-smart --to typst -o "$tmp/body.typ"
cat print/book/template.typ "$tmp/body.typ" > "$tmp/main.typ"
python3 - "$tmp" <<'PY'
import sys, typst
tmp = sys.argv[1]
import os
inputs = {k: v for k, v in (("font", os.environ.get("FONT")),
                            ("size", os.environ.get("FONT_SIZE"))) if v}
typst.compile(f"{tmp}/main.typ", output=os.environ.get("OUT", "print/book/interior.pdf"),
              font_paths=["print/fonts"] + os.environ.get("FONT_DIRS", "").split(":"),
              root=tmp, sys_inputs=inputs)
PY
echo "Wrote print/book/interior.pdf"
