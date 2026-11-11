// Visual polish (V1-V9) and scenario 10. `--input notes=on` renders the
// speaker-note panel on a second screen; `--input aspect=4-3` the narrow
// format.
#import "@preview/unofficial-monash-touying:1.0.0": *

#let notes = sys.inputs.at("notes", default: "off") == "on"

#show: monash-theme.with(
  aspect-ratio: sys.inputs.at("aspect", default: "16-9"),
  outline: false,
  slide-numbering: "1 / 1",
  config-common(show-notes-on-second-screen: if notes { right } else { none }),
  config-info(title: [Visual Polish], author: [Test Author]),
)

#show: show-monash-frames

#title-slide()

= Tables and figures

// Scenario 10: a three-column table and a captioned figure.
== Table and figure

#grid(
  columns: (1.1fr, 1fr),
  column-gutter: 1.2cm,
  figure(
    table(
      columns: 3,
      table.header[Method][Accuracy][Time (s)],
      [Baseline], [71.2%], [12.4],
      [Ours], [78.9%], [10.1],
      [Ours + tuning], [80.3%], [14.8],
    ),
    caption: [Results on the validation split.],
  ),
  figure(
    rect(width: 100%, height: 3.2cm, fill: monash-blue-wash, stroke: .6pt + monash-blue)[
      #align(center + horizon, text(fill: monash-blue)[figure placeholder])
    ],
    caption: [A captioned figure drawn with shapes.],
  ),
)

#speaker-note[Point at the second row of the table.]

== A table with its own arguments

User arguments win over the theme's set rules.

#table(
  columns: 3,
  stroke: 1pt + red,
  fill: none,
  [A], [B], [C],
  [1], [2], [3],
)

== Opting out of the header row

The README's opt-out: the first row is styled as a header unless the table
sets its own fill and stroke and a show rule resets the first row's text.

#[
  #show table.cell.where(y: 0): set text(weight: "regular", fill: black)
  #table(
    columns: 3,
    fill: none,
    stroke: .5pt + black,
    [A], [B], [C],
    [1], [2], [3],
  )
]

= Text

== Lists by level

- First level item
  - Second level item
    - Third level item
      - Fourth level cycles back
  - Second level again
- First level again

+ First level step
  + Second level step
    + Third level step
  + Second level step again
+ First level step again

== Links and code

Visit #link("https://www.monash.edu")[the university website]; outline
entries and references are not styled as links.

Inline code such as `let x = 1` sits at about 0.85em of the text, and a
long span such as `normalize(features, mean=features.mean(), std=features.std())`
breaks across lines like ordinary text.

```python
def mse(y, pred):
    return ((y - pred) ** 2).mean()
```

// Measured check of V4: the width of code glyphs relative to the same
// glyphs at body size.
#context {
  let mono = measure(text(font: "DejaVu Sans Mono")[MMMM]).width
  let inline = measure(raw("MMMM")).width
  text(size: .6em, fill: monash-dark-grey)[
    Inline code glyphs: #calc.round(inline / mono, digits: 2)em of the body
    size. Block code keeps Typst's 0.8em.
  ]
}

// Inline code in a slide heading and on a focus slide is drawn in the code
// font and the surrounding text colour, without the light code box.
== Calling `normalize(x)` in a heading

Inline code in the body keeps its box: `normalize(x)`.

#focus-slide[Prefer `pathlib` over `os.path`.]
