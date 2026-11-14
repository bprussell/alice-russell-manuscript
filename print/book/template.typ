// Print edition layout: 6 x 9 in hardcover interior.
// The body (body.typ) is generated from book/ by build.sh via pandoc.

#let author = "Alice Reynolds Russell"
#let title-one = "Sealed Secrets"
#let title-two = "Kashema"

#set document(title: title-one + " & " + title-two, author: author)
#let body-font = sys.inputs.at("font", default: "Sorts Mill Goudy")
#let body-size = float(sys.inputs.at("size", default: "11.5")) * 1pt
#set text(font: body-font, size: body-size, lang: "en", hyphenate: true)
#set par(justify: true, leading: 0.62em, spacing: 0.62em,
         first-line-indent: (amount: 1.3em, all: false))
#show heading: set text(weight: "regular")
// Quotes are curled before pandoc (print/smartquotes.py), but pandoc writes
// every ’ back out as a straight ' — so a straight single quote here is
// always an apostrophe or closing quote, never an opening one.
#set smartquote(quotes: (single: ("’", "’"), double: ("“", "”")))

// --- Pandoc helpers -------------------------------------------------------
#let horizontalrule = align(center, block(above: 1.1em, below: 1.1em,
  text(size: 10pt, tracking: 0.6em)[\* \* \*]))
#show quote.where(block: true): it => pad(left: 1.6em, right: 1.6em,
  block(above: 1em, below: 1em, {
    set par(first-line-indent: 0pt, justify: false)
    it.body
  }))
// The one table in the book (her daily schedule, Book One ch. X): no rules,
// left-aligned like a typed list, and free to run onto the next page.
#show table: set text(size: 10pt)
#set table(stroke: none, inset: (x: 0.8em, y: 0.26em))
#show table.cell: set align(left)
#show figure.where(kind: table): set block(breakable: true, above: 0.7em, below: 0.9em)
// "Weekdays:" follows the Sunday table, so it would lose its paragraph
// indent; give it back so it lines up with "Sunday:".
#show "Weekdays:": it => h(1.3em) + it

// --- Page furniture ---------------------------------------------------------
// Running heads and folios start with the foreword, and are left off pages
// where a part or chapter opens and off blank pages (no body paragraph).
#let furniture = state("furniture", false)
#show par: it => [#metadata(none)<txt>#it]
#let bare-page() = {
  let pg = here().page()
  (not furniture.get()
    or query(heading.where(level: 1).or(heading.where(level: 2))).any(h => h.location().page() == pg)
    or query(<plate>).any(m => m.location().page() == pg)
    or not query(<txt>).any(m => m.location().page() == pg))
}
#let current-part() = {
  let parts = query(selector(<toc>).before(here())).filter(m => "head" in m.value)
  if parts.len() > 0 { parts.last().value.head } else { [] }
}
#let running-head = context {
  if bare-page() { return }
  set text(size: 8.5pt, tracking: 0.12em)
  if calc.even(here().page()) { align(center, upper(author)) }
  else { align(center, emph(current-part())) }
}
#let folio = context {
  if bare-page() { return }
  set text(size: 9.5pt)
  align(center, counter(page).display())
}

#set page(width: 6in, height: 9in, binding: left,
  margin: (inside: 0.9in, outside: 0.65in, top: 0.85in, bottom: 0.85in),
  header: running-head, header-ascent: 0.2in,
  footer: folio, footer-descent: 0.15in)

// --- Headings -------------------------------------------------------------
// Level 1 = a book (part) title page; level 2 = chapter or front-matter section.
#show heading.where(level: 1): it => {
  pagebreak(to: "odd", weak: true)
  v(2.1in)
  align(center, it.body)
  pagebreak(to: "odd")
}
#show heading.where(level: 2): it => {
  pagebreak(weak: true)
  v(1.35in)
  align(center, text(size: 15pt, tracking: 0.06em, it.body))
  v(0.45in)
}

#show heading.where(level: 3): it => block(above: 1.5em, below: 0.9em,
  align(center, text(size: 10pt, tracking: 0.14em, upper(it.body))))

#let part(number, title) = {
  pagebreak(to: "odd", weak: true)
  [#metadata((name: [Book #number: #emph(title)], head: title)) <toc>]
  heading(level: 1, outlined: true, bookmarked: true)[#block[
    #text(size: 11pt, tracking: 0.35em, upper[Book #number])
    #v(0.35in)
    #text(size: 22pt, style: "italic", title)
  ]]
}
#let section(name) = {
  pagebreak(weak: true)
  furniture.update(true)
  [#metadata((name: name, head: name)) <toc>]
  heading(level: 2, outlined: true)[#name]
}

// A full-page picture with a caption; no running head or folio.
#let plate(path, caption, width: 82%) = {
  [#metadata(none)<plate>]
  v(1fr)
  align(center, image(path, width: width))
  v(0.18in)
  align(center, block(width: 85%, {
    set par(first-line-indent: 0pt, justify: false)
    text(size: 9pt, style: "italic", caption)
  }))
  v(1fr)
}

// --- Front matter -----------------------------------------------------------
#set page(numbering: "i")

// Half title
#v(2.6in)
#align(center, text(size: 15pt, style: "italic")[#title-one \ #text(size: 11pt, style: "normal")[&] \ #title-two])
#pagebreak()

// Frontispiece (verso, facing the title page)
#plate("images/alice-and-john.jpg", width: 74%)[Alice Parapa-Rosa Reynolds and
  John Sidney Russell, about the time of their marriage in 1905]
#pagebreak()

// Title page
#v(1.7in)
#align(center)[
  #text(size: 24pt, style: "italic", title-one)
  #v(0.25in)
  #text(size: 12pt)[and]
  #v(0.25in)
  #text(size: 24pt, style: "italic", title-two)
  #v(1.1in)
  #text(size: 13pt, tracking: 0.2em, upper(author))
]
#pagebreak()

// Edition notice (verso of title)
#v(1fr)
#set par(first-line-indent: 0pt)
#text(size: 9pt)[
  Written by #author of Edelstein, Illinois, in the early twentieth
  century, and preserved in typescript by her family.

  #v(0.5em)
  This family edition was transcribed and edited from the original
  typescript in 2026. The titles are those the family history records
  for the book's two parts; the titles first typed on the manuscript were
  later erased by the author.

  #v(0.5em)
  Set in #body-font.
]
#set par(first-line-indent: (amount: 1.3em, all: false))
#pagebreak(to: "odd")

// Contents
#align(center, text(size: 15pt, tracking: 0.06em)[Contents])
#v(0.45in)
#context for m in query(<toc>) {
  let loc = m.location()
  let pg = numbering(loc.page-numbering(), ..counter(page).at(loc))
  block(above: 1em, grid(columns: (1fr, auto), m.value.name, pg))
}

// --- Body -----------------------------------------------------------------
// (body appended here by build.sh)
