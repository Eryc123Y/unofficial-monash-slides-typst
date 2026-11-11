// A short talk: no outline and no section dividers, so a 12-minute slot is
// spent on content.
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  outline: false,
  section-slides: false,
  title-graphic: none,
  config-info(
    title: [Three Things About Typst],
    author: [Your Name],
    institution: [Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= Speed

== It Compiles Fast

- Incremental compilation updates the preview as you type.
- A full deck compiles in about a second.

= Scripting

== It Is Programmable

```typst
#for n in range(3) [Slide #n ]
```

- Functions, loops, and modules are part of the language.

#focus-slide[
  Your slides are code, so they can be reviewed like code.
]

= Ecosystem

== It Has Packages

- Touying for slides, CeTZ for drawings, and many more on Typst Universe.

#ending-slide[
  Slides made with `unofficial-monash-touying`.
]
