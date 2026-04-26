#import "@preview/touying:0.7.3": touying-fn-wrapper
#import "theme.typ": monash-blue, monash-blue-light, monash-red, monash-charcoal, monash-slate

#let _panel(
  self: none,
  title: none,
  accent: monash-blue,
  fill: monash-blue-light,
  body,
) = block(
  width: 100%,
  inset: 0pt,
  stroke: (paint: accent, thickness: .8pt),
  radius: 6pt,
  grid(
    columns: 1,
    row-gutter: 0pt,
    if title != none {
      block(
        width: 100%,
        fill: accent,
        inset: (x: .65em, y: .35em),
        text(fill: white, weight: "bold", title),
      )
    },
    block(
      width: 100%,
      fill: fill,
      inset: .75em,
      body,
    ),
  ),
)

#let _callout(
  self: none,
  title: none,
  accent: monash-red,
  fill: white,
  body,
) = block(
  width: 100%,
  fill: fill,
  stroke: (paint: accent.lighten(45%), thickness: .6pt),
  radius: 2pt,
  grid(
    columns: (.25em, 1fr),
    rect(width: 100%, height: 100%, fill: accent, stroke: none),
    block(
      inset: (x: .85em, y: .65em),
      [
        #if title != none {
          text(fill: accent, weight: "bold", title)
          v(.35em)
        }
        #body
      ],
    ),
  ),
)

#let info-block(title: none, body) = touying-fn-wrapper(
  _panel.with(title: title, accent: monash-blue, fill: monash-blue-light, body),
)

#let alert-block(title: [Important], body) = touying-fn-wrapper(
  _callout.with(title: title, accent: monash-red, fill: monash-red.lighten(94%), body),
)

#let result-block(title: [Result], body) = touying-fn-wrapper(
  _panel.with(title: title, accent: monash-charcoal, fill: monash-slate.lighten(86%), body),
)

#let metric-row(..items) = touying-fn-wrapper(self => {
  let values = items.pos()
  grid(
    columns: (1fr,) * values.len(),
    gutter: .6em,
    ..values.map(value => block(
      fill: monash-blue-light,
      radius: 5pt,
      inset: .7em,
      align(center + horizon, value),
    )),
  )
})
