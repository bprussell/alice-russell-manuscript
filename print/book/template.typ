// Print edition layout: 6 x 9 in hardcover interior.
// The body (body.typ) is generated from book/ by build.sh via pandoc.

#let author = "Alice Reynolds Russell"
#let title-one = "The Locket of Family Secrets"
#let title-two = "The Heir of the Broken Chain"

#set document(title: title-one + " & " + title-two, author: author)
#let body-font = sys.inputs.at("font", default: "Sorts Mill Goudy")
#let body-size = float(sys.inputs.at("size", default: "11.5")) * 1pt
#set text(font: body-font, size: body-size, lang: "en", hyphenate: true)
#set par(justify: true, leading: 0.62em, spacing: 0.62em,
         first-line-indent: (amount: 1.3em, all: false))
#show heading: set text(weight: "regular")

// --- Pandoc helpers -------------------------------------------------------
#let horizontalrule = align(center, block(above: 1.1em, below: 1.1em,
  text(size: 10pt, tracking: 0.6em)[\* \* \*]))
#show quote.where(block: true): it => pad(left: 1.6em, right: 1.6em,
  block(above: 1em, below: 1em, {
    set par(first-line-indent: 0pt, justify: false)
    it.body
  }))
#show table: set text(size: 9.5pt)

// --- Page furniture ---------------------------------------------------------
// Running heads and folios start with the foreword, and are left off pages
// where a part or chapter opens and off blank pages (no body paragraph).
#let furniture = state("furniture", false)
#show par: it => [#metadata(none)<txt>#it]
#let bare-page() = {
  let pg = here().page()
  (not furniture.get()
    or query(heading.where(level: 1).or(heading.where(level: 2))).any(h => h.location().page() == pg)
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
  header: running-head, header-ascent: 40%,
  footer: folio, footer-descent: 40%)

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
  [#metadata((name: name)) <toc>]
  heading(level: 2, outlined: true)[#name]
}

// --- Front matter -----------------------------------------------------------
#set page(numbering: "i")

// Half title
#v(2.6in)
#align(center, text(size: 15pt, style: "italic")[#title-one \ #text(size: 11pt, style: "normal")[&] \ #title-two])
#pagebreak()
#pagebreak()  // blank verso

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
  typescript in 2026. The original titles were erased by the author;
  the title of Book Two is reconstructed from the impression left in the
  paper, and the title of Book One was composed by the family around its
  two surviving words.

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
