#import "@preview/touying:0.7.3": *
#import themes.university: focus-slide
#import "@preview/theorion:0.6.0": *
#import "@preview/algo:0.3.6": *
#import cosmos.simple: theorem, definition, show-theorion
#import "components.typ": info-block
#import "theme.typ": monash-blue, monash-red, monash-charcoal, monash-slate

#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
    config,
  )

  let info = self.info + args.named()
  let display-logo = if info.logo != none {
    info.logo
  } else if info.institution != none {
    text(size: .68em, fill: monash-blue, weight: "bold", info.institution)
  } else {
    text(size: .68em, fill: monash-blue, weight: "bold")[Monash University]
  }

  let date-line = if info.date != none {
    utils.display-info-date(self)
  } else {
    none
  }

  let meta = (
    if info.author != none { info.author },
    if info.institution != none { info.institution },
    if date-line != none { date-line },
  ).filter(item => item != none)

  let slide-body = {
    grid(
      columns: (18%, 1fr),
      block(
        height: 100%,
        width: 100%,
        fill: monash-blue,
        [
          #place(top + left)[
            #rect(width: 100%, height: .28em, fill: monash-red, stroke: none)
          ]
          #place(bottom + left, dx: 1.2em, dy: -1.2em)[
            #text(size: .55em, fill: white, weight: "bold")[UNOFFICIAL\ STUDENT\ TEMPLATE]
          ]
        ],
      ),
      block(
        height: 100%,
        width: 100%,
        fill: white,
        inset: (left: 2.4em, right: 2.2em, top: 1.35em, bottom: 1.35em),
        [
          #place(top + right)[#display-logo]
          #align(left + horizon)[
            #text(size: .75em, fill: monash-red, weight: "bold")[PRESENTATION]
            #v(.45em)
            #block(width: 76%)[
              #text(size: 2.18em, fill: monash-charcoal, weight: "bold", info.title)
            ]
            #if info.subtitle != none {
              v(.55em)
              text(size: 1.05em, fill: monash-blue, info.subtitle)
            }
            #v(1.25em)
            #rect(width: 4.4em, height: .18em, fill: monash-blue, stroke: none)
            #v(1.1em)
            #text(size: .72em, fill: monash-slate, meta.join([   |   ]))
            #if extra != none {
              v(.65em)
              text(size: .65em, fill: monash-slate, extra)
            }
          ]
        ],
      ),
    )
  }

  touying-slide(self: self, slide-body)
})

#let section-slide(body) = focus-slide(background-color: monash-blue)[
  #body
]

#let closing-slide(..args, body) = focus-slide(background-color: monash-charcoal, ..args)[
  #body
]

#let _slide-title(title) = if title != auto and title != none {
  text(size: 1.05em, weight: "bold", fill: monash-charcoal, title)
  v(.2em)
  rect(width: 2.6em, height: .12em, fill: monash-blue, stroke: none)
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
    radius: 2pt,
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
