// Set and show rules applied to every slide body through Touying's `init`.

#import "@preview/zebraw:0.6.3": zebraw
#import "design.typ": *

#let _heading-three(it) = {
  v(1em, weak: true)
  text(weight: "bold", fill: monash-blue, it.body)
  v(.7em, weak: true)
}

#let _list-rules(accent, body) = {
  set list(
    marker: (
      box(width: .55em, height: .55em, baseline: -.05em, fill: accent),
      text(fill: accent.lighten(20%), size: .75em)[#sym.triangle.filled.r],
      text(fill: accent.lighten(20%), size: .75em)[#sym.star.filled],
    ),
    indent: 1.2em,
    body-indent: .6em,
  )
  set enum(
    full: true,
    numbering: (..nums) => box(
      fill: accent,
      inset: (x: 4pt, y: 2pt),
      text(fill: white, size: .72em, weight: "bold")[#nums.pos().last()],
    ),
    indent: 1.2em,
    body-indent: .8em,
  )
  body
}

#let _code-rules(body) = {
  show raw.where(block: false): it => box(
    fill: monash-blue-wash,
    stroke: (paint: monash-grey-soft, thickness: .45pt),
    radius: 1.5pt,
    inset: (x: .18em, y: .04em),
    baseline: .08em,
    text(size: .68em, fill: monash-blue-dark, weight: "medium", it),
  )
  show raw.where(block: true): set text(size: .72em, fill: monash-charcoal)
  show: zebraw.with(
    background-color: monash-grey-light,
    highlight-color: monash-blue-wash,
    lang: false,
    radius: 2pt,
    inset: (x: space-md, y: space-sm),
    numbering: false,
  )
  body
}

/// Body rules of the theme, as a Touying `init` method.
#let slide-rules(accent, self: none, body) = {
  set par(justify: false, leading: .65em)
  set figure(placement: none)
  show heading.where(level: 3): _heading-three
  show heading.where(level: 4): set text(fill: monash-blue, weight: "bold")
  show strong: it => text(fill: accent, weight: "bold", it.body)
  show: _list-rules.with(accent)
  show: _code-rules
  body
}
