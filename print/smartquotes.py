#!/usr/bin/env python3
"""Curl the straight quotes in the reading text for typesetting.

Pandoc's own smart-quote handling misreads a quote nested inside dialogue
(she typed straight double quotes for both levels): in
    "...finding the "missing link" in their chain..."
it takes the inner opening mark as the end of the outer quote, curls it
backwards and drops the space. This script curls quotes itself, tracking
nesting per paragraph, and renders a double quote nested inside another
as single quotes (American convention). Run the build with
`--from markdown-smart` so pandoc leaves the result alone.

Reads Markdown on stdin, writes it to stdout.
"""
import re
import sys

# Words she types with a leading apostrophe for dropped letters
# ('phone, 'bout, 'Twas ...): these take an apostrophe, not an opening quote.
ELISIONS = {"phone", "phoned", "bout", "twas", "tis", "twould", "till", "til",
            "though", "em", "cross", "flu", "round", "ologies", "kerchiefs"}

OPENERS = set(" \t\n—–-([*") | {"“", "‘"}


def curl_paragraph(p):
    out = []
    stack = []  # "d" = double, "n" = double nested inside double, "s" = single
    for i, ch in enumerate(p):
        prev = p[i - 1] if i else " "
        nxt = p[i + 1] if i + 1 < len(p) else " "
        if ch == '"':
            opening = not nxt.isspace() and (prev in OPENERS or
                                            (prev.isalnum() and nxt.isalnum() and not stack))
            if opening:
                if "d" in stack:
                    out.append("‘"); stack.append("n")
                else:
                    out.append("“"); stack.append("d")
            else:
                # close the innermost open double-level quote
                while stack and stack[-1] == "s":
                    stack.pop()
                kind = stack.pop() if stack else "d"
                out.append("’" if kind == "n" else "”")
        elif ch == "'":
            word = re.match(r"[A-Za-z]+", p[i + 1:])
            if prev.isalnum() and nxt.isalnum():
                out.append("’")                      # don't, it's
            elif word and word.group(0).lower() in ELISIONS and prev in OPENERS:
                out.append("’")                      # 'phone, 'Twas
            elif prev in OPENERS and not nxt.isspace():
                out.append("‘"); stack.append("s")   # opening single quote
            else:
                if stack and stack[-1] == "s":
                    stack.pop()
                out.append("’")                      # closing single / plural possessive
        else:
            out.append(ch)
    return "".join(out)


def main():
    text = sys.stdin.read()
    paras = re.split(r"(\n\s*\n)", text)
    for k in range(0, len(paras), 2):
        block = paras[k]
        if block.lstrip().startswith("|"):          # tables: leave alone
            continue
        block = re.sub(r"(?<=\w)--(?=\w)", "–", block)  # "to--m--o--rr--ow"
        paras[k] = curl_paragraph(block)
    sys.stdout.write("".join(paras))


if __name__ == "__main__":
    main()
