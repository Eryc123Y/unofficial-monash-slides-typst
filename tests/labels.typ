// `show-monash-frames(labels: ..)` replaces single labels, in frames,
// references, and proofs.
//   --input override=on   replace two labels
#import "@preview/unofficial-monash-touying:1.1.0": *

#let override = sys.inputs.at("override", default: "off") == "on"

#show: monash-theme.with(
  outline: false,
  config-info(title: [Labels]),
)

#show: show-monash-frames.with(
  labels: if override { (theorem: "Thm", proof: [Beweis]) } else { (:) },
)

#title-slide()

== Frames and a reference

#definition[Term][Body.]
#theorem[Banach][Body.] <thm>
#lemma[Body.]

A reference: @thm.

== Proofs

#proof[Body.]
#proof[Sketch][Body.]

#ending-slide[Contact details.]
