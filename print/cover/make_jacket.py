#!/usr/bin/env python3
"""Lay out the dust jacket (print/cover/jacket.html) on Lulu's template.

Geometry is measured from Lulu's template for this book
(print/book/yv69v4d-cover-template.pdf: 286 pp, 60# cream, linen wrap):
20.694 x 9.75 in with 0.25 in bleed; flaps 3.25 in, folds 0.25 in,
covers 6.25 in (from fold line to spine), spine 0.944 in; text kept 0.5 in
inside every cover and flap edge. The front cover art is the Claude Design
front panel (design/FrontPanel.dc.html), placed unchanged.
Run from the repository root; build.sh turns the HTML into the PDF.
"""
import os, re

ROOT = os.getcwd()
GROUND, GOLD, CREAM = "#1F3A2E", "#C9A961", "#EFE6D2"
W, H, BLEED = 20.694, 9.75, 0.25
# panel x-ranges in inches (visible edges, from the template)
BACK_FLAP = (0.25, 3.50); BACK = (3.75, 9.875); SPINE = (9.875, 10.819)
FRONT = (10.819, 16.944); FRONT_FLAP = (17.194, 20.444)
TOP, BOTTOM = 0.25, 9.50          # cover top/bottom edges
LIVE_TOP, LIVE_BOTTOM = 0.75, 9.00

def font(name):
    return "file://" + os.path.join(ROOT, "print/fonts", name)

def front_panel():
    s = open("print/cover/design/FrontPanel.dc.html").read()
    s = s[s.index("</helmet>") + 9: s.index("</x-dc>")]
    s = s.replace("{{ground}}", GROUND).replace("{{gold}}", GOLD)
    # run the chain off the top edge of the jacket
    s = s.replace("M96 -90 Q136.0 30", "M84 -150 Q136.0 30").replace("M224 -90 Q184.0 30", "M236 -150 Q184.0 30")
    return s

ORNAMENT = (f'<svg width="120" height="14" viewBox="0 0 120 14" style="display:block;margin:0 auto;color:{GOLD}">'
            '<line x1="0" y1="7" x2="48" y2="7" stroke="currentColor" stroke-width="1"/>'
            '<path d="M60 1 L66 7 L60 13 L54 7 Z" fill="none" stroke="currentColor" stroke-width="1.2"/>'
            '<circle cx="60" cy="7" r="1.6" fill="currentColor"/>'
            '<line x1="72" y1="7" x2="120" y2="7" stroke="currentColor" stroke-width="1"/></svg>')

def box(x0, x1, y0, y1, inner, style=""):
    return (f'<div style="position:absolute;left:{x0}in;top:{y0}in;width:{x1-x0:.3f}in;'
            f'height:{y1-y0:.3f}in;{style}">{inner}</div>')

def main():
    fx = FRONT[0] + (FRONT[1] - FRONT[0] - 6) / 2      # 6 x 9 in front panel, centred
    fy = TOP + (BOTTOM - TOP - 9) / 2
    front = box(fx, fx + 6, fy, fy + 9, front_panel())

    spine_text = (f'<p style="margin:0;writing-mode:vertical-rl;font-size:17px;letter-spacing:0.18em;'
                  f'white-space:nowrap;color:{CREAM}">SEALED SECRETS &amp; KASHEMA '
                  f'<span style="color:{GOLD};letter-spacing:0">·</span> '
                  f'<span style="color:{GOLD}">ALICE REYNOLDS RUSSELL</span></p>')
    rule = lambda a, b: (f'<div style="width:46px;display:flex;flex-direction:column;gap:3px">'
                         f'<div style="height:{a}px;background:{GOLD}"></div><div style="height:{b}px;background:{GOLD}"></div></div>')
    spine = box(SPINE[0], SPINE[1], LIVE_TOP - 0.1, LIVE_BOTTOM + 0.1,
                rule(1.5, 1) + spine_text + rule(1, 1.5),
                "display:flex;flex-direction:column;align-items:center;justify-content:space-between")

    back = box(BACK[0] + 0.5, BACK[1] - 0.5, LIVE_TOP, LIVE_BOTTOM,
               f'{ORNAMENT}<p style="margin:34px 0 18px;font-size:23px;line-height:1.5;font-style:italic;'
               f'text-align:center;text-wrap:balance">“An autobiography that glides freely between the '
               f'factual and the fanciful. You are never just sure which is which.”</p>'
               f'<p style="margin:0 0 34px;font-size:13px;letter-spacing:0.16em;text-align:center;color:{GOLD}">'
               f'FROM THE RUSSELL FAMILY HISTORY</p>{ORNAMENT}',
               "display:flex;flex-direction:column;justify-content:center")

    p = 'style="margin:0 0 14px;font-size:14.5px;line-height:1.5;text-wrap:pretty"'
    front_flap = box(FRONT_FLAP[0] + 0.5, FRONT_FLAP[1] - 0.5, LIVE_TOP + 0.35, LIVE_BOTTOM,
        f'<p style="margin:0 0 4px;font-size:21px;font-style:italic;text-align:center;line-height:1.2">Sealed Secrets</p>'
        f'<p style="margin:0 0 18px;font-size:21px;text-align:center;line-height:1.2">'
        f'<span style="color:{GOLD};font-size:16px">&amp;</span> <i>Kashema</i></p>'
        f'<div style="margin:0 0 22px">{ORNAMENT}</div>'
        f'<p {p}><i>Sealed Secrets</i> follows a dreamy, freckle-faced farm girl, Alice Parepa-Roza Wesley, '
        f'from her father’s farm to her aunt and uncle’s home in Peoria. <i>Kashema</i> returns to her years later.</p>'
        f'<p {p}>Written by Alice Reynolds Russell of Edelstein, Illinois, early in the twentieth century, '
        f'kept for a hundred years in a box of loose typewritten pages, and set in type for the first time '
        f'for her family.</p>')

    photo = "file://" + os.path.join(ROOT, "print/cover/allie-and-johnie-50th.jpg")
    back_flap = box(BACK_FLAP[0] + 0.5, BACK_FLAP[1] - 0.5, LIVE_TOP + 0.35, LIVE_BOTTOM,
        f'<div style="padding:5px;border:1.5px solid {GOLD};border-radius:6px">'
        f'<img src="{photo}" style="display:block;width:100%;border-radius:3px;filter:sepia(0.3) contrast(1.04)"></div>'
        f'<p style="margin:8px 0 22px;font-size:11.5px;line-height:1.4;font-style:italic;text-align:center">'
        f'Alice and John Russell on their fiftieth wedding anniversary, 1955</p>'
        f'<p {p}>Alice Parepa-Rosa Reynolds Russell (1881–1975) taught at the Kellogg school, raised three '
        f'sons on farms around Edelstein, and lectured across central Illinois on her flowers and her '
        f'button collection. She wrote five books; these two are the only ones known to survive.</p>')

    html = f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>Sealed Secrets &amp; Kashema: dust jacket</title>
<style>
@font-face{{font-family:"Sorts Mill Goudy";src:url({font("SortsMillGoudy-Regular.ttf")});font-style:normal}}
@font-face{{font-family:"Sorts Mill Goudy";src:url({font("SortsMillGoudy-Italic.ttf")});font-style:italic}}
@page{{size:1490pt 702pt;margin:0}}
html,body{{margin:0;padding:0}}
body{{width:{W}in;height:{H}in;position:relative;overflow:hidden;background:{GROUND};
  color:{CREAM};font-family:"Sorts Mill Goudy",serif;-webkit-print-color-adjust:exact;print-color-adjust:exact}}
</style></head><body>
{back_flap}{back}{spine}{front}{front_flap}
</body></html>'''
    open("print/cover/jacket.html", "w").write(html)
    print("Wrote print/cover/jacket.html")

if __name__ == "__main__":
    main()
