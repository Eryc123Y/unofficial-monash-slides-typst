// Scenario 7: each theme option visibly changes the output. scripts/check.sh
// compiles this deck once per variant:
//   typst compile tests/options.typ --input variant=logo
// Variants: default, no-progress-bar, logo, logo-crest, logo-both,
// logo-bar-only, logo-oversized, footer-auto, authors-array,
// numbering-total, numbering-none, accent-teal, no-section-slides,
// no-outline, plain-cover. The logos are placeholder SVGs in tests/assets.
// Add `--input aspect=4-3` for the narrow format.
#import "@preview/unofficial-monash-touying:1.0.0": *

#let variant = sys.inputs.at("variant", default: "default")
#let aspect = sys.inputs.at("aspect", default: "16-9")

#let wordmark = image("assets/placeholder-wordmark.svg")
#let wordmark-white = image("assets/placeholder-wordmark-white.svg")
#let crest = image("assets/placeholder-crest.svg")

#let options = (
  default: (:),
  no-progress-bar: (progress-bar: false),
  // Plain content: the title slide only.
  logo: (logo: wordmark),
  logo-crest: (logo: crest),
  // One image per place.
  logo-both: (logo: (cover: wordmark, bar: wordmark-white)),
  logo-bar-only: (logo: (bar: wordmark-white)),
  // Far too large in both directions: still bounded in each place.
  logo-oversized: (logo: (
    cover: rect(width: 40cm, height: 10cm, fill: monash-blue-dark),
    bar: rect(width: 40cm, height: 1cm, fill: white),
  )),
  footer-auto: (footer: auto),
  authors-array: (footer: auto),
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
    author: if variant == "authors-array" { ("First Author", "Second Author") } else { [Test Author] },
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

#ending-slide[
  Test Author \
  #link("mailto:test.author@example.edu")[test.author\@example.edu]
]
