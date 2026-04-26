#import "@preview/touying:0.7.3": *
#import themes.university: title-slide as touying-title-slide, focus-slide
#import "@preview/theorion:0.6.0": *
#import "@preview/algo:0.3.6": *
#import cosmos.simple: theorem, definition, show-theorion
#import "components.typ": info-block
#import "theme.typ": monash-blue, monash-blue-light, monash-red, monash-charcoal

#let title-slide(..args) = touying-title-slide(..args)

#let section-slide(body) = focus-slide(background-color: monash-blue)[
  #body
]

#let closing-slide(..args, body) = focus-slide(background-color: monash-charcoal, ..args)[
  #body
]

#let _slide-title(title) = if title != auto and title != none {
  text(size: 1.15em, weight: "bold", fill: monash-blue, title)
  v(.45em)
}

#let two-column-slide(title: auto, left: none, right: none, columns: (1fr, 1fr), gutter: 1em) = slide[
  #_slide-title(title)
  #grid(
    columns: columns,
    column-gutter: gutter,
    left,
    right,
  )
]

#let equation-slide(title: auto, body) = slide[
  #_slide-title(title)
  #align(center + horizon, text(size: 1.35em, body))
]

#let code-slide(title: auto, body) = slide[
  #_slide-title(title)
  #block(
    width: 100%,
    fill: monash-charcoal,
    radius: 6pt,
    inset: .8em,
    text(fill: white, body),
  )
]

#let theorem-slide(title: auto, theorem-title: none, body) = slide[
  #_slide-title(title)
  #show: show-theorion
  #theorem(theorem-title)[#body]
]

#let definition-slide(title: auto, definition-title: none, body) = slide[
  #_slide-title(title)
  #show: show-theorion
  #definition(definition-title)[#body]
]

#let proof-slide(title: auto, proof-title: none, body) = slide[
  #_slide-title(title)
  #info-block(title: if proof-title == none { [Proof sketch] } else { proof-title })[
    #body
  ]
]

#let algorithm-slide(title: auto, body) = slide[
  #_slide-title(title)
  #info-block(title: [Algorithm])[
    #body
  ]
]
