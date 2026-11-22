// Back links: a target lists the other slides that point at it.
//   --input backlinks=off   links go one way only
//   --input style=plain     the light frame style
//   --input bib=apa         an author-date bibliography
#import "@preview/unofficial-monash-touying:1.1.0": *

#show: monash-theme.with(
  outline: false,
  section-slides: false,
  backlinks: sys.inputs.at("backlinks", default: "on") == "on",
  config-info(title: [Back links]),
)
#show: show-monash-frames.with(style: sys.inputs.at("style", default: "filled"))
#set math.equation(numbering: "(1)")

== The targets

#theorem[Banach][Every contraction has a unique fixed point.] <banach>

#lemma[Not referred to from another slide, so it shows no links.] <helper>

The key assumption#anchor(<assumption>) is completeness; #anchor(<setup>)[the setup] is standard.

On the same slide, @banach and @helper add no back link.

== More targets

#figure(
  table(columns: 2, [Method], [Error], [Ours], [0.1]),
  caption: [Results.],
) <results>

$ x_(n+1) = T x_n $ <iteration>

#figure(rect(width: 4em, height: 2em), caption: [Not referred to.]) <unused>

== First use

By @banach and @iteration, the iteration converges; see @results and
@vaswani2017attention. #goto(<assumption>)[Recall the assumption.]

== A slide with pauses

Before the pause we recall @banach.

#pause

After the pause the slide is still listed once.

== Second use

@banach again, with #goto(<setup>)[the setup] and #goto(<banach>)[the theorem by name],
@devlin2019bert, and @vaswani2017attention.

== References

#bibliography("../examples/refs.bib", style: sys.inputs.at("bib", default: "ieee"))
