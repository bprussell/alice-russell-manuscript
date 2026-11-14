import math
cx, cy, rx, ry = 160, 255, 100, 125   # case
G, GL, GD, GDD = "#B8914A", "#D9BE82", "#7A5B2A", "#4E3818"
o=[]
o.append('<svg width="320" height="420" viewBox="0 0 320 420" aria-hidden="true" style="display:block">')
o.append('<defs>')
o.append(f'<pattern id="hatch" width="4" height="4" patternUnits="userSpaceOnUse" patternTransform="rotate(35)"><line x1="0" y1="0" x2="0" y2="4" stroke="{GDD}" stroke-width="1.1"/></pattern>')
o.append(f'<mask id="shade"><ellipse cx="{cx}" cy="{cy}" rx="{rx}" ry="{ry}" fill="#fff"/><ellipse cx="{cx-14}" cy="{cy-16}" rx="{rx-6}" ry="{ry-8}" fill="#000"/></mask>')
o.append(f'<mask id="hl"><ellipse cx="{cx}" cy="{cy}" rx="{rx-4}" ry="{ry-4}" fill="#fff"/><ellipse cx="{cx+12}" cy="{cy+14}" rx="{rx-4}" ry="{ry-6}" fill="#000"/></mask>')
o.append('</defs>')
# chain: two strands from top converging on ring
ringy = 112
for x0 in (96, 224):
    d = f"M{x0} -90 Q{(x0+cx)/2 + (8 if x0<cx else -8)} 30 {cx + (-5 if x0<cx else 5)} {ringy-9}"
    o.append(f'<path d="{d}" fill="none" stroke="{GD}" stroke-width="4.2" stroke-linecap="round" stroke-dasharray="5 3.2"/>')
    o.append(f'<path d="{d}" fill="none" stroke="{GL}" stroke-width="2.4" stroke-linecap="round" stroke-dasharray="5 3.2" stroke-dashoffset="4.1"/>')
# jump ring + bail
o.append(f'<ellipse cx="{cx}" cy="{ringy}" rx="9" ry="12" fill="none" stroke="{GD}" stroke-width="5"/>')
o.append(f'<ellipse cx="{cx}" cy="{ringy}" rx="9" ry="12" fill="none" stroke="{G}" stroke-width="2.6"/>')
o.append(f'<path d="M{cx-11} 122 h22 a4 4 0 0 1 4 4 v6 h-30 v-6 a4 4 0 0 1 4 -4 z" fill="{G}" stroke="{GDD}" stroke-width="1.4"/>')
o.append(f'<ellipse cx="{cx}" cy="134" rx="18" ry="5" fill="{G}" stroke="{GDD}" stroke-width="1.4"/>')
# hinge knuckles on right
for dy in (-22, 0, 22):
    o.append(f'<rect x="{cx+rx-5}" y="{cy+dy-9}" width="11" height="17" rx="4" fill="{G}" stroke="{GDD}" stroke-width="1.3"/>')
# case
o.append(f'<ellipse cx="{cx}" cy="{cy}" rx="{rx}" ry="{ry}" fill="{G}" stroke="{GDD}" stroke-width="2"/>')
o.append(f'<rect x="0" y="0" width="320" height="420" fill="url(#hatch)" mask="url(#shade)" opacity="0.55"/>')
o.append(f'<ellipse cx="{cx}" cy="{cy}" rx="{rx-4}" ry="{ry-4}" fill="none" stroke="{GL}" stroke-width="3" mask="url(#hl)" opacity="0.8"/>')
# bezel rings
for (a,b,w) in ((rx-11, ry-11, 1.6), (rx-17, ry-17, 0.9)):
    o.append(f'<ellipse cx="{cx}" cy="{cy}" rx="{a}" ry="{b}" fill="none" stroke="{GDD}" stroke-width="{w}"/>')
# beaded border
n=56
for i in range(n):
    t = 2*math.pi*i/n
    x = cx + (rx-6)*math.cos(t); y = cy + (ry-6)*math.sin(t)
    o.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="1.7" fill="{GL}" stroke="{GDD}" stroke-width="0.6"/>')
# engraved rosette
for k in range(8):
    ang = k*45
    o.append(f'<ellipse cx="{cx}" cy="{cy-17}" rx="7" ry="17" fill="none" stroke="{GDD}" stroke-width="1.2" transform="rotate({ang} {cx} {cy})"/>')
o.append(f'<circle cx="{cx}" cy="{cy}" r="6" fill="none" stroke="{GDD}" stroke-width="1.2"/>')
o.append(f'<circle cx="{cx}" cy="{cy}" r="2" fill="{GDD}"/>')
# scroll vines up and down, mirrored
def vine(sy):
    s = []
    for sx in (1,-1):
        p = (f"M{cx} {cy+sy*40} C{cx+sx*10} {cy+sy*60} {cx+sx*42} {cy+sy*58} {cx+sx*40} {cy+sy*80} "
             f"C{cx+sx*38} {cy+sy*94} {cx+sx*22} {cy+sy*94} {cx+sx*24} {cy+sy*84}")
        s.append(f'<path d="{p}" fill="none" stroke="{GDD}" stroke-width="1.3" stroke-linecap="round"/>')
        # leaves
        lx, ly = cx+sx*20, cy+sy*58
        s.append(f'<path d="M{lx} {ly} q{sx*10} {-sy*12} {sx*20} {-sy*4} q{-sx*10} {sy*10} {-sx*20} {sy*4} z" fill="none" stroke="{GDD}" stroke-width="1.1"/>')
        s.append(f'<path d="M{cx+sx*46} {cy+sy*30} q{sx*16} {sy*6} {sx*14} {sy*24}" fill="none" stroke="{GDD}" stroke-width="1.1" stroke-linecap="round"/>')
    s.append(f'<path d="M{cx} {cy+sy*28} L{cx} {cy+sy*40}" stroke="{GDD}" stroke-width="1.2"/>')
    return s
o += vine(1) + vine(-1)
o.append('</svg>')
open('locket.svg','w').write("\n".join(o))
