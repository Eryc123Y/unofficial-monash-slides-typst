#import "@preview/frame-it:2.0.0": frames, frame-style
#import "design.typ": *

#let _has-title(title) = title not in (none, [], "")

#let monash-frame-style(title, tags, body, supplement, number, accent-color) = {
  let title-line = if _has-title(title) {
    [#supplement #number: #title]
  } else {
    [#supplement #number]
  }

  block(
    width: 100%,
    fill: monash-paper,
    stroke: (
      left: (paint: accent-color, thickness: monash-frame-rule),
      rest: (paint: monash-grey-soft, thickness: .45pt),
    ),
    radius: 2pt,
    inset: (x: monash-space-md, y: monash-space-sm),
    [
      #text(size: .58em, fill: accent-color, weight: "bold", title-line)
      #if tags.len() > 0 {
        h(monash-space-sm)
        text(size: .5em, fill: monash-muted, tags.join([, ]))
      }
      #if body != [] {
        v(monash-space-sm)
        text(size: .86em, fill: monash-charcoal, body)
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
  theorem: ("Theorem", monash-blue),
  proof: ("Proof", monash-blue-dark),
  lemma: ("Lemma", monash-blue-dark),
  corollary: ("Corollary", monash-blue-dark),
  remark: ("Remark", monash-slate),
  note: ("Note", monash-slate),
  warning: ("Warning", monash-charcoal),
)
