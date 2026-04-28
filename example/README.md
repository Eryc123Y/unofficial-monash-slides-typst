# Usage Guide

This guide shows the normal authoring path for `unofficial-monash-touying`.
The package stays close to Touying: use Touying for slide structure and use
this package for the Monash-inspired theme, code styling, and academic frame
environments.

For a complete deck that compiles all of these pieces together, see
`example/main.typ`.

## Start from the Template

Create a new deck with the bundled template:

```sh
typst init @preview/unofficial-monash-touying:0.1.0 my-slides
```

The generated project contains the starter `main.typ` and the bundled
logo-free title background asset.

## Minimal Existing-Deck Setup

Use this preamble when adding the package to an existing Touying deck:

````typst
#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "@preview/unofficial-monash-touying:0.1.0": *

#show: monash-theme.with(
  config-info(
    title: [Presentation Title],
    short-title: [Short Title],
    subtitle: [Subtitle],
    author: [Your Name],
    institution: [Monash University],
    date: datetime.today(),
  ),
)

#show: show-monash-frames

#title-slide()
````

`monash-theme` installs the Touying theme. `show-monash-frames` installs the
definition, theorem, lemma, corollary, note, warning, remark, and proof
environments.

## Add a Table of Contents Slide

By default, `#title-slide()` only creates the title slide. Enable `toc` when a
deck should show a table of contents immediately after the title:

````typst
#show: monash-theme.with(
  toc: true,
  config-info(title: [Presentation Title]),
)

#title-slide()
````

The table of contents lists level-one headings, automatically uses up to three
columns for longer decks, and can hide section numbers with
`toc-numbering: false`.

For manual placement, call `#toc-slide()` where the table of contents should
appear.

## Write Slides with Touying

Use normal Touying heading structure:

````typst
= Section

== Slide Title

- First point
- Second point
  - Nested point

#pause

This appears after the pause.
````

Level-one headings create section divider slides by default. To keep level-one
headings as structure without divider slides, set:

````typst
#show: monash-theme.with(
  section-slides: false,
  config-info(title: [Presentation Title]),
)
````

The package does not add a custom slide wrapper. Touying headings, `#slide`,
`#pause`, composers, and other Touying features remain the authoring surface.

## Title Graphics and Logos

The starter template includes a logo-free title background. For a project with
approved assets, pass your own title graphic or logo:

````typst
#let title-background = image(
  "assets/title-background.png",
  width: 100%,
  height: 100%,
  fit: "cover",
)

#show: monash-theme.with(
  titlegraphic: title-background,
  logo: image("assets/logo.svg", height: 1.25em),
  config-info(
    title: [Presentation Title],
    author: [Your Name],
  ),
)
````

`titlegraphic` may be an image path string or Typst content. If no logo is
provided, the theme shows a text fallback.

## Academic Frames

Place academic frame environments directly inside slides:

````typst
#definition[Loss Function][
  A loss function maps a prediction and target to a scalar penalty.
]

#theorem[Convergence Sketch][
  Under suitable assumptions, gradient descent converges.
]

#lemma[Descent Lemma][
  One optimization step decreases the objective.
]

#proof[Sketch][
  Apply the descent lemma and telescope the inequalities.
]

#remark[Design][
  Remarks are styled like frames but remain unnumbered.
]
````

Definitions, theorems, lemmas, corollaries, notes, and warnings are numbered
independently by environment type. Remarks are always unnumbered.

To hide visible frame numbers while keeping the styling:

````typst
#show: show-monash-frames.with(numbering: false)
````

## Code Blocks

Inline code and fenced raw blocks are styled automatically:

````typst
Inline code such as `#slide` uses a light wash.

```python
def mse(y, pred):
    return ((y - pred) ** 2).mean()
```
````

The package uses `zebraw` internally, but users can keep ordinary Typst raw
block syntax.

## Manual Slides

Use Touying's `#slide` for one-off layouts:

````typst
#slide[
  #align(center + horizon)[
    #text(size: 1.4em, weight: "bold")[Manual slide content]
  ]
]
````

This is useful for closing slides, diagrams, or dense custom layouts. Regular
slides should usually stay as level-two headings.

## Local Development

Run the repository check script before publishing changes:

```sh
./scripts/check.sh
```

The script compiles the starter template, example deck, generated reference,
and thumbnail through a temporary local package path. That means the absolute
package imports used by real users are tested before release.
