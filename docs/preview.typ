// Source of thumbnail.png and docs/preview/*.png. It mirrors the template's
// title slide with a fixed date and the default font, so the published
// preview matches what `typst init` gives a new user.
// Regenerate with `scripts/check.sh --thumbnail`.
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  outline: false,
  config-info(
    title: [Presentation Title],
    short-title: [Short Title],
    subtitle: [Subtitle],
    author: [Your Name],
    institution: [Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= Introduction

== Motivation

- State the problem in one sentence.
- Say why it matters.
  - Add detail at a second level when needed.

+ Background
+ Method

Inline code such as `x.mean()` matches fenced blocks:

```python
def mean(values):
    return sum(values) / len(values)
```

== Key Results

#definition[Term][
  A definition states exactly what a word means in this talk.
]

#theorem[Main Result][
  Under the stated assumptions, the method converges.
]

#proof[Sketch the argument in one or two sentences.]
