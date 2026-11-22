// Back links: a frame lists the other slides that refer to it.
//   --input backlinks=off   references link one way only
//   --input style=plain     the light frame style
#import "@preview/unofficial-monash-touying:1.1.0": *

#show: monash-theme.with(outline: false, section-slides: false, config-info(title: [Back links]))
#show: show-monash-frames.with(
  backlinks: sys.inputs.at("backlinks", default: "on") == "on",
  style: sys.inputs.at("style", default: "filled"),
)

== The statement

#theorem[Banach][Every contraction has a unique fixed point.] <banach>

#lemma[Not referred to from another slide, so it shows no links.] <helper>

On the same slide, @banach and @helper add no back link.

== First use

By @banach, the iteration converges.

== A slide with pauses

Before the pause we recall @banach.

#pause

After the pause the slide is still listed once.

== Second use on the same slide twice

@banach again, and once more @banach.
