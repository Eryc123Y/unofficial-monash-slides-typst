#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "../lib.typ": *

#set text(font: ("Arial", "New Computer Modern"))

#let monash-logo = image("../template/assets/Monash_University_logo.svg", height: 1em)

#show: monash-theme.with(
  logo: monash-logo,
  config-info(
    title: [Frame Environments],
    short-title: [Frames],
    subtitle: [Definitions, theorems, proofs, and notes],
    author: [Template Author],
    institution: [Monash University],
    date: datetime.today(),
  ),
)

#show: show-monash-frames

#title-slide()

= Frame Environments

== Mathematical Frames

#definition[Metric Space][
  A metric space is a set $X$ equipped with a distance function
  $d: X times X -> RR$ satisfying non-negativity, symmetry, and triangle
  inequality.
]

#theorem[Contraction Mapping][Fixed Point][
  Every contraction on a complete metric space has a unique fixed point.
]

== Proof, Lemma, Corollary

#lemma[Picard Iteration][
  The Picard sequence is Cauchy under a contraction.
]

#proof[Sketch][
  Construct the Picard sequence $x_(n+1) = T(x_n)$. The contraction property
  makes the sequence Cauchy, so completeness gives a limit, which is the fixed
  point.
]

#corollary[Uniqueness][
  If a fixed point exists for a contraction, it is unique.
]

== Remarks

#remark[Style][
  Remarks use the same neutral frame treatment with quieter charcoal emphasis.
]

#note[Usage][
  These frames are ordinary content blocks and can be placed inside Touying
  slides without changing the Touying authoring model.
]

#warning[Scope][
  This package does not provide an algorithm DSL. Use Typst raw blocks or import
  another package when a deck needs pseudocode.
]
