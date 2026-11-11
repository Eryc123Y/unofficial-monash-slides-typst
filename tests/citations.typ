// Scenario 11 (C1, C2): citations shown as footnotes on the slide where
// they are made, and a compact bibliography that continues onto a further
// slide when it is long. `--input footnotes=off` checks C1 alone.
#import "@preview/unofficial-monash-touying:1.0.0": *

#let footnotes = sys.inputs.at("footnotes", default: "on") == "on"

#show: monash-theme.with(
  outline: false,
  config-common(show-bibliography-as-footnote: footnotes),
  config-info(title: [Citations]),
)

#title-slide()

= Results

== Cited on the slide

Transformers @vaswani2017attention replaced recurrence, and residual
connections @he2016resnet made very deep networks trainable.

- Earlier sequence models used LSTMs @hochreiter1997lstm.
- Typesetting owes much to @knuth1984texbook.

== Another slide

Back-propagation @rumelhart1986learning and dropout @srivastava2014dropout.

== References

// `full: true` lists every entry, so the list is long enough to continue
// onto a second slide. (Citing the remaining entries inside `hide` instead
// makes Touying 0.8.0's footnote citations fail to converge.)
#bibliography("refs.bib", style: "ieee", full: true)
