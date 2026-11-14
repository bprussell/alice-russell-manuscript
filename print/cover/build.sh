#!/usr/bin/env bash
# Builds the dust jacket PDF for Lulu: print/cover/jacket.pdf
# Needs python3 and node with playwright (Chromium).
set -euo pipefail
cd "$(dirname "$0")/../.."
python3 print/cover/make_jacket.py
node -e '
const {chromium} = require("playwright");
(async () => {
  const b = await chromium.launch();
  const p = await b.newPage();
  await p.goto("file://" + process.cwd() + "/print/cover/jacket.html");
  await p.evaluate(() => document.fonts.ready);
  await p.pdf({path: "print/cover/jacket.pdf",  
               printBackground: true, preferCSSPageSize: true});
  await b.close();
})();'
echo "Wrote print/cover/jacket.pdf"
# Chromium rounds the page to 1/96 in (1489.92 pt); set it to Lulu's exact
# 1490 x 702 pt. Same-length replacement, so the PDF's byte offsets hold.
python3 - <<'PY'
p = "print/cover/jacket.pdf"; b = open(p, "rb").read()
old = b"/MediaBox [0 0 1489.91992 702]"
new = b"/MediaBox [0 0 1490 702]".ljust(len(old))
assert b.count(old) == 1, "unexpected MediaBox"
open(p, "wb").write(b.replace(old, new))
print("Set page size to 1490 x 702 pt (20.694 x 9.75 in)")
PY
