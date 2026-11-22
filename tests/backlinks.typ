// Back links: the name of a target links back when exactly one other slide
// points at it. scripts/check.sh checks the links of the PDF.
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

// Referred to from one other slide: a link back.
#theorem[Once][Used on one other slide.] <once>

// Referred to from two other slides: no link back.
#theorem[Twice][Used on two other slides.] <twice>

// Referred to from this slide only: no link back.
#lemma[Used here only.] <here-only>

#anchor(<assumption>)[The key assumption] is completeness; @here-only is local.

== More targets

#figure(
  table(columns: 2, [Method], [Error], [Ours], [0.1]),
  caption: [Results.],
) <results>

$ x_(n+1) = T x_n $ <iteration>

#figure(rect(width: 4em, height: 2em), caption: [Not referred to.]) <unused>

== A slide with pauses

@once before the pause, and @once again: one slide, so one way back.

#pause

@twice, @iteration, @results, #goto(<assumption>)[the assumption], and
@vaswani2017attention.

== Another use

@twice a second time, with @devlin2019bert and @vaswani2017attention.

== References

#bibliography("../examples/refs.bib", style: sys.inputs.at("bib", default: "ieee"))
