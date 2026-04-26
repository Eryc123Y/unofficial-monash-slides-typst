#import "@preview/frame-it:2.0.0": frames, frame-style
#import "design.typ": *

#let _has-title(title) = title not in (none, [], "")

#let _frame-fill(accent-color) = if accent-color == monash-charcoal {
  monash-grey-light
} else {
  accent-color.transparentize(93%)
}

#let monash-frame-style(title, tags, body, supplement, number, accent-color) = {
  let title-line = if _has-title(title) {
    [#supplement #number: #title]
  } else {
    [#supplement #number]
  }

  block(
    width: 100%,
    fill: _frame-fill(accent-color),
    stroke: (
      left: (paint: accent-color, thickness: monash-frame-rule),
      rest: (paint: monash-grey-soft, thickness: .55pt),
    ),
    radius: 2pt,
    inset: 0pt,
    [
      #block(
        width: 100%,
        fill: accent-color,
        inset: (x: monash-space-md, y: monash-space-xs),
        [
          #text(size: .68em, fill: white, weight: "bold", title-line)
          #if tags.len() > 0 {
            h(monash-space-sm)
            text(size: .52em, fill: white.transparentize(25%), tags.join([, ]))
          }
        ],
      )
      #if body != [] {
        block(
          width: 100%,
          inset: (x: monash-space-md, y: monash-space-sm),
          text(size: .84em, fill: monash-charcoal, body),
        )
      }
    ],
  )
}

#let show-monash-frames(body) = {
  show figure.where(kind: "frame"): set align(left)
  show: frame-style(monash-frame-style)
  body
}

#let (
  definition,
  theorem,
  proof,
  lemma,
  corollary,
  remark,
  note,
  warning,
) = frames(
  definition: ("Definition", monash-blue),
  theorem: ("Theorem", monash-teal),
  proof: ("Proof", monash-charcoal),
  lemma: ("Lemma", monash-blue-grey),
  corollary: ("Corollary", monash-green),
  remark: ("Remark", monash-slate),
  note: ("Note", monash-blue-dark),
  warning: ("Warning", monash-charcoal),
)
