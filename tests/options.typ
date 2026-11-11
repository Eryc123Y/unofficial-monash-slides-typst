// Scenario 7: each theme option visibly changes the output. scripts/check.sh
// compiles this deck once per variant:
//   typst compile tests/options.typ --input variant=logo
// Variants: default, no-progress-bar, logo, footer-auto, numbering-total,
// numbering-none, accent-teal, no-section-slides, no-outline, plain-cover.
// Add `--input aspect=4-3` for the narrow format.
#import "@preview/unofficial-monash-touying:1.0.0": *

#let variant = sys.inputs.at("variant", default: "default")
#let aspect = sys.inputs.at("aspect", default: "16-9")

// A stand-in logo drawn with shapes, deliberately much taller than the
// title bar so that the height bound is exercised.
#let test-logo = box(
  width: 3cm,
  height: 3cm,
  fill: white,
  stroke: 2pt + monash-blue,
  radius: 4pt,
  align(center + horizon, text(size: 40pt, fill: monash-blue, weight: "bold")[LG]),
)

#let options = (
  default: (:),
  no-progress-bar: (progress-bar: false),
  logo: (logo: test-logo),
  footer-auto: (footer: auto),
  numbering-total: (slide-numbering: "1 / 1"),
  numbering-none: (slide-numbering: none),
  accent-teal: (accent-color: teal),
  no-section-slides: (section-slides: false),
  no-outline: (outline: false),
  plain-cover: (title-graphic: none),
).at(variant)

#show: monash-theme.with(
  aspect-ratio: aspect,
  ..options,
  config-info(
    title: [Options Test Deck],
    short-title: [Options],
    subtitle: [Variant: #raw(variant)],
    author: [Test Author],
    institution: [Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= First section

== Lists and emphasis

Text with *strong emphasis* in the accent colour.

- First level marker
  - Second level marker
+ Numbered item
+ Another numbered item

== A slide with a heading long enough to wrap under the logo in this deck

#theorem[Statement][Body text inside a theorem frame.]

= Second section

== Last slide

The progress bar is full here.
