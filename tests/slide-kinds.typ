// A3: outline-slide anywhere, focus-slide, ending-slide, and the slide
// counter they leave untouched. `--input sections=off` turns section
// divider slides off; sections still feed the outline and bookmarks.
#import "@preview/unofficial-monash-touying:1.0.0": *

#let sections = sys.inputs.at("sections", default: "on") == "on"

#show: monash-theme.with(
  aspect-ratio: sys.inputs.at("aspect", default: "16-9"),
  section-slides: sections,
  slide-numbering: "1 / 1",
  footer: auto,
  config-info(
    title: [Slide Kinds],
    author: [Test Author],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= Introduction

== First slide

Slide numbers count content slides only.

#focus-slide[One statement, shown large on its own slide.]

== After the focus slide

The number continues from the slide before the focus slide.

= A section with a long title that needs to wrap onto a second line here

== Middle slide

The outline slide below can be placed anywhere.

#outline-slide(title: [Where we are])

== After a mid-deck outline

Content.

#ending-slide[
  Test Author \
  #link("mailto:test.author@example.edu")[test.author\@example.edu] \
  #link("https://example.edu")[example.edu]
]
