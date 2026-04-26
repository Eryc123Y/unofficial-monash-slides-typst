#import "../lib.typ": *
#import "@preview/touying:0.7.3": *
#import "@preview/algo:0.3.6": algo, i, d

#set text(font: ("Arial", "New Computer Modern"))

#show: monash-theme.with(
  campus: [Monash University Malaysia],
  config-info(
    title: [Monash Student Slides],
    short-title: [Student Slides],
    subtitle: [A Touying presentation template],
    author: [Your Name],
    institution: [Monash University],
    date: datetime.today(),
  ),
)

#title-slide()

= Motivation

== A Clean Academic Deck

#info-block(title: [Design intent])[
  This unofficial template uses a restrained Monash-inspired palette, clear
  hierarchy, and Touying's slide mechanics.
]

#alert-block[
  Official Monash logo assets are not bundled. Pass your own logo through the
  `logo` option if you have permission to use one.
]

== Mathematical Content

#theorem-slide(title: [Theorem], theorem-title: [Convergence sketch])[
  If $f$ is convex and $L$-smooth, gradient descent with a suitable step size
  satisfies $f(x_t) - f(x^*) = O(1 / t)$.
]

== Code

#code-slide(title: [Python Example])[
```python
def mse(y, pred):
    return ((y - pred) ** 2).mean()
```
]

== Algorithm

#algorithm-slide(title: [Training Loop])[
  #algo(
    title: "Train",
    parameters: ("model", "data"),
  )[
    for batch in data:#i\
      compute loss\
      update parameters#d\
  ]
]

== Two Columns

#two-column-slide(
  title: [Comparison],
  left: [
    #result-block(title: [Before])[
      Manual slide formatting creates repeated layout work.
    ]
  ],
  right: [
    #result-block(title: [After])[
      A template centralises visual and academic conventions.
    ]
  ],
)

#closing-slide[Questions?]

