// Scenario 13: with `--input handout=true` the two slides with pauses
// collapse to one page each (4 pages instead of 7). scripts/check.sh
// compares the page counts.
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  outline: false,
  section-slides: false,
  config-common(handout: sys.inputs.at("handout", default: "false") == "true"),
  config-info(title: [Handout]),
)

#title-slide()

= Animations

== Pauses

First.

#pause

Second.

#pause

Third.

== Uncover

#uncover(2)[Shown from the second subslide.]

#only(1)[Only on the first subslide.]

== Static

No animation here.
