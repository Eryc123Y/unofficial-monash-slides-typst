# Monash Student Slides

An unofficial Monash-style presentation package for Typst. It is intentionally
thin: Touying remains the slide authoring system, while this package supplies a
Monash theme and theorem-like environments styled with `frame-it`.

## Usage

```typst
#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "@preview/monash-student-slides:0.1.0": *

#let monash-logo = image("assets/Monash_University_logo.svg", height: 1.25em)

#show: monash-theme.with(
  logo: monash-logo,
  brand-motif: true,
  motto: [Ancora Imparo],
  progress-position: "footer",
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

= Section

== Slide Title

Use normal Touying content.

#definition[Term][
  A definition can be placed directly inside a slide.
]
```

## Public API

- `monash-theme`
- `show-monash-frames`
- `monash-frame-style`
- `monash-facade-pattern`
- `monash-campus-grid`
- `monash-accent-rule`
- `monash-microbrand`
- `definition`
- `theorem`
- `proof`
- `lemma`
- `corollary`
- `remark`
- `note`
- `warning`

The package does not provide custom slide wrappers. Use Touying's own headings,
`#slide`, `#pause`, composers, and other presentation features directly.

## Development Harness

Run:

```sh
./scripts/check.sh
```

The harness compiles the template deck, the frame environment example, and the
thumbnail.

## Design Notes

The default visual language uses a restrained Monash-inspired palette and
abstract campus elements drawn directly in Typst: a light facade rhythm inspired
by campus architecture, low-contrast wayfinding/grid lines, and the optional
`Ancora Imparo` microbrand. Monash red is not used in the default theme.
