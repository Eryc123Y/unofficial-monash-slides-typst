// Stress deck for the layout scenarios in docs/v1-spec.md section 6.
// scripts/check.sh compiles it for both aspect ratios:
//   typst compile tests/stress.typ --input aspect=4-3
#import "@preview/unofficial-monash-touying:1.0.0": *

#let aspect = sys.inputs.at("aspect", default: "16-9")

#show: monash-theme.with(
  aspect-ratio: aspect,
  config-info(
    // Scenario 1: four-line title, two-line subtitle, three authors, a long
    // institution, and a date.
    title: [A Long Title That Keeps Going Across Several Lines to Test How the Cover Handles Wrapping of Research Titles],
    subtitle: [A subtitle that is also long enough to need a second line on the cover slide],
    author: [Ada Lovelace, Grace Hopper, and Katherine Johnson],
    institution: [Department of Data Science and Artificial Intelligence, Faculty of Information Technology, Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide(extra: [Seminar series, room G12])

= Headings

// Scenario 2: a slide heading of about 90 characters.
== A slide heading of about ninety characters that cannot possibly fit on a single title line

The body starts below the title bar.

- First point
- Second point

== A heading just a little too long to fit on one line at the full size

This heading should shrink a little instead of wrapping.

= Frames

// Scenario 3: two paragraphs, a list, a display equation, and a sentence.
== Rich frame

#theorem[Rich content][
  The first paragraph states the setting of the result in a couple of
  sentences.

  The second paragraph adds a condition.

  - a bullet point inside the frame
  - another bullet point

  $ integral_0^1 f(x) dif x = F(1) - F(0) $

  A trailing sentence closes the statement.
]

== Code inside a frame

#note[Code][
  A paragraph before the code.

  ```python
  def area(r):
      return 3.14159 * r ** 2
  ```

  A paragraph after the code.
]

= Footnotes and lists

// Scenario 6: footnote text must sit fully above the footer.
== Footnote

A claim that needs a source.#footnote[The source of the claim, given in a footnote long enough to wrap onto a second line on the narrower format.]

- More content on the slide.
- Even more content.

// R10: numbered lists to three nested levels.
== Numbered lists

+ First level
  + Second level
    + Third level
    + Third level again
  + Second level again
+ First level again

== Bulleted lists

- First level
  - Second level
    - Third level
      - Fourth level cycles

= Appendix test

== Last main slide

The progress bar is full here, and the total counts main slides only.

// Scenario 8: an appendix with two slides.
#show: appendix

= Backup

== Backup slide one

Appendix content.

== Backup slide two

More appendix content.
