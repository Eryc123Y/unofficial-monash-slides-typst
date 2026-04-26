#import "@preview/frame-it:2.0.0": frames, frame-style
#import "theme.typ": monash-blue, monash-blue-dark, monash-charcoal, monash-slate, monash-grey, monash-grey-light

#let _has-title(title) = title not in (none, [], "")

#let monash-frame-style(title, tags, body, supplement, number, accent-color) = {
  let title-line = if _has-title(title) {
    [#supplement #number: #title]
  } else {
    [#supplement #number]
  }

  block(
    width: 100%,
    fill: monash-grey-light,
    stroke: (
      left: (paint: accent-color, thickness: 2.2pt),
      rest: (paint: monash-grey, thickness: .55pt),
    ),
    radius: 2pt,
    inset: (x: .75em, y: .58em),
    [
      #text(size: .72em, fill: accent-color, weight: "bold", title-line)
      #if tags.len() > 0 {
        h(.45em)
        text(size: .58em, fill: monash-slate, tags.join([, ]))
      }
      #if body != [] {
        v(.4em)
        text(fill: monash-charcoal, body)
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
