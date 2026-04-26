#import "../lib.typ": *
#import "@preview/touying:0.7.3": *
#import "@preview/algo:0.3.6": algo, i, d

#set text(font: ("Arial", "New Computer Modern"))

#show: monash-theme.with(
  campus: [Clayton / Malaysia / Online],
  config-info(
    title: [Code, Theorem, Algorithm],
    short-title: [Academic Helpers],
    subtitle: [Core helper environments],
    author: [Template Author],
    institution: [Monash University],
    date: datetime.today(),
  ),
)

#title-slide()

= Helpers

== Definition

#definition-slide(title: [Definition], definition-title: [Risk])[
  The empirical risk is $R(theta) = 1/n sum_(i=1)^n "loss"(f_theta(x_i), y_i)$.
]

== Proof Sketch

#proof-slide(title: [Proof Sketch])[
  Use smoothness to upper-bound one optimization step, then telescope the
  resulting inequality over $t = 1, dots, T$.
]

== Code

#code-slide(title: [Loss Function])[
```python
def empirical_risk(model, batch):
    x, y = batch
    return loss(model(x), y)
```
]

== Pseudocode

#algorithm-slide(title: [Mini-batch Update])[
  #algo(
    title: "Mini-batch SGD",
    parameters: ("theta", "data"),
  )[
    repeat until convergence:#i\
      sample mini-batch\
      estimate gradient\
      update theta#d\
  ]
]

#closing-slide[Thank you]
