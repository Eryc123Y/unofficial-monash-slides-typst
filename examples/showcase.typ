// Feature tour of unofficial-monash-touying.
// Compile with `--input font=Arial` to see the deck in Arial.
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  font: sys.inputs.at("font", default: auto),
  footer: auto,
  slide-numbering: "1 / 1",
  config-info(
    title: [Unofficial Monash Touying],
    short-title: [Monash Touying],
    subtitle: [A tour of the theme],
    author: [Your Name],
    institution: [Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= Getting Started

== Minimal Preamble

```typst
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  config-info(title: [Title], author: [Your Name]),
)
#show: show-monash-frames

#title-slide()
```

Level-one headings start sections; level-two headings start slides.

== Options at a Glance

#table(
  columns: (auto, auto, 1fr),
  table.header[Option][Default][Effect],
  [`font`], [`auto`], [Typst's default font; `"Arial"` for the Monash look],
  [`title-graphic`], [`auto`], [bundled background, `none`, or an image],
  [`outline`], [`true`], [outline slide after the title slide],
  [`section-slides`], [`true`], [a divider slide per section],
  [`footer`], [`none`], [`auto` shows short title and author],
  [`slide-numbering`], [`"1"`], [`"1 / 1"` adds the total; `none` hides it],
)

= Content

== Lists

- Level one uses a filled square
  - Level two a hollow square
    - Level three a dash
- *Strong text* takes the accent colour

+ Numbered steps use filled boxes
  + then outlined letters
    + then roman numerals

== Animation

Content appears step by step.

#pause

- Use `#pause` between items,
#pause
- or `#item-by-item` for a whole list.

#meanwhile

`#meanwhile` shows content from the first step onwards.

== Columns

#slide(composer: (1fr, 1fr))[
  *Question*

  How does the method behave when the input distribution changes?
][
  *Plan*

  - compare against a baseline
  - report the failure case
]

== Tables and Figures

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1cm,
  figure(
    table(
      columns: 3,
      table.header[Model][Params][Accuracy],
      [Small], [12M], [71.2%],
      [Base], [86M], [78.9%],
      [Large], [307M], [80.3%],
    ),
    caption: [Accuracy by model size.],
  ),
  figure(
    rect(width: 100%, height: 3cm, fill: monash-blue-wash, stroke: .6pt + monash-blue)[
      #align(center + horizon, text(fill: monash-blue)[your figure])
    ],
    caption: [Figures take a muted caption.],
  ),
)

== Code

Inline code such as `x.mean()` and fenced blocks share one style.

```python
def normalize(x):
    return (x - x.mean()) / x.std()
```

Links look like #link("https://typst.app/universe")[links].

= Environments

== Definitions and Theorems

#definition[Empirical Risk][
  The average loss over a finite training set:
  $hat(R)(theta) = 1 / n sum_(i=1)^n ell(f_theta (x_i), y_i)$.
]

#theorem[Convergence][
  If $f$ is convex and $L$-smooth, gradient descent with step size $1 slash L$
  satisfies

  $ f(x_t) - f(x^*) <= (L norm(x_0 - x^*)^2) / (2 t). $
] <convergence>

== Proofs and References

#lemma[Descent][
  One gradient step decreases $f$ by at least $norm(nabla f)^2 slash 2L$.
]

#proof[Sketch][
  Telescope the descent lemma over $t$ steps; this proves @convergence.
]

== Other Kinds

#example[Mean squared error is a convex loss.]

#remark[Remarks, notes, and warnings are never numbered.]

#warning[Check the step size before you run it.]

#focus-slide[
  One idea per slide.
]

= Wrapping Up

== Summary

- `title-slide`, `outline-slide`, `focus-slide`, `ending-slide`
- eleven environments plus `proof`
- options for fonts, footer, numbering, and colours

#ending-slide[
  Your Name \
  #link("mailto:your.name@monash.edu")[your.name\@monash.edu]
]
