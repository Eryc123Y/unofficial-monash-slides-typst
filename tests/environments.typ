// Scenarios 4 and 5: environment call shapes, counters, and references.
// scripts/check.sh compiles three variants:
//   --input counter=default   Theorem 1, Lemma 1
//   --input counter=shared    Theorem 1, Lemma 2
//   --input counter=off       no numbers
#import "@preview/unofficial-monash-touying:1.0.0": *

#let mode = sys.inputs.at("counter", default: "default")

#show: monash-theme.with(
  outline: false,
  config-info(title: [Environments: #raw(mode)]),
)

#show: show-monash-frames.with(
  numbering: mode != "off",
  shared-counter: mode == "shared",
)

#title-slide()

= Call shapes

== Body only and title plus body

#theorem[A body without a title.] <thm-first>

#theorem[Named][A body with a title.]

#proof[A proof with a body only.]

#proof[Sketch][A proof with a title, whose end mark sits at the right of the last line.]

== Counters across kinds

#definition[Term][Defined here.] <def-term>

#lemma[Helper][A lemma after two theorems and a definition.] <lem-helper>

#corollary[A corollary.]

#proposition[A proposition.]

#assumption[An assumption.]

== Examples, exercises, and unnumbered kinds

#example[An example.]
#exercise[An exercise.]

#remark[A remark is never numbered.]
#note[A note is never numbered.]
#warning[A warning is never numbered.]

== References

See @thm-first, @def-term, and @lem-helper.

A custom supplement: @thm-first[Claim]. A page reference:
#ref(<thm-first>, form: "page").

== A frame on a slide with pauses

#theorem[Counted once][Shown before the pause.]

#pause

#lemma[A lemma revealed after the pause.] <lem-paused>

The lemma is @lem-paused.
