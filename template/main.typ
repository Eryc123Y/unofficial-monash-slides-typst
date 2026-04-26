#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "../lib.typ": *

#set text(font: ("Arial", "New Computer Modern"))

#let monash-logo = image("assets/Monash_University_logo.svg", height: 1.25em)

#show: monash-theme.with(
  logo: monash-logo,
  config-info(
    title: [Monash Student Slides],
    short-title: [Student Slides],
    subtitle: [A Touying presentation template],
    author: [Your Name],
    institution: [Monash University],
    date: datetime.today(),
  ),
)

#show: show-monash-frames

#title-slide()

= Foundations

== Native Touying Syntax

This template keeps Touying as the authoring model.

- Use headings to create sections and slides.
- Use `#slide` when you want manual slide control.
- Use Touying features such as `#pause` directly.
  - Nested bullets use a quieter grey marker.

#pause

After the pause, the same slide continues without any package-specific wrapper.

=== Styled Content Heading

Use level-three headings for compact content sections.

==== Detail Heading

Use level-four headings for smaller subdivisions inside dense slides.

== Definition and Theorem

#definition[Loss Function][
  A loss function maps a prediction and target to a scalar penalty:
  $"loss": cal(Y) times cal(Y) -> RR$.
]

#theorem[Convergence Sketch][
  If $f$ is convex and $L$-smooth, gradient descent with a suitable step size
  satisfies $f(x_t) - f(x^*) = O(1 / t)$.
]

#corollary[Rate][
  Under the same assumptions, the average regret decreases sublinearly.
]

== Proof and Lemma

#lemma[Descent Lemma][
  Smoothness gives an upper bound on one optimization step.
]

#proof[Sketch][
  Apply the descent lemma at each iterate and telescope the resulting
  inequalities.
]

== Notes and Warnings

#note[Usage][
  Frame environments are ordinary content blocks, so they can be inserted in
  any Touying slide.
]

#remark[Design][
  Default frames use neutral surfaces, compact title rows, and distinct accent
  colours inside the Monash minimal palette.
]

#warning[Scope][
  This package does not define an algorithm DSL. Import a dedicated package when
  a deck needs pseudocode.
]

== Raw Code

```
def mse(y, pred):
    return ((y - pred) ** 2).mean()
```

== Closing

#slide[
  #align(center + horizon)[
    #text(size: 1.6em, fill: monash-blue, weight: "bold")[Thank you]
  ]
]
