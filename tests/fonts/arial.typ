// requires-font: Arial
// Scenario 12: the stress deck's content in Arial, the recommended font.
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  font: "Arial",
  aspect-ratio: sys.inputs.at("aspect", default: "16-9"),
  footer: auto,
  config-info(
    title: [A Long Title That Keeps Going Across Several Lines to Test How the Cover Handles Wrapping in Arial],
    subtitle: [A subtitle that is also long enough to need a second line on the cover slide],
    author: [Ada Lovelace, Grace Hopper, and Katherine Johnson],
    institution: [Department of Data Science and Artificial Intelligence, Faculty of Information Technology, Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= Headings

== A slide heading of about ninety characters that cannot possibly fit on a single title line

- First point
  - Second level
    - Third level

== Rich frame

#theorem[Rich content][
  The first paragraph states the setting.

  The second paragraph adds a condition.

  - a bullet point inside the frame

  $ integral_0^1 f(x) dif x = F(1) - F(0) $

  A trailing sentence closes the statement.
]

== Footnote

A claim that needs a source.#footnote[The source of the claim.]
