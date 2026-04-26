# Monash Student Slides

An unofficial Monash-style presentation package for Typst. It is intentionally
thin: Touying remains the slide authoring system, while this package supplies a
Monash theme, theorem-like environments styled with `frame-it`, and a
Monash-styled code block treatment powered by `zebraw`.

## Usage

````typst
#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "@preview/monash-student-slides:0.1.0": *

#let monash-logo = image("assets/Monash_University_logo.svg", height: 1.25em)

#show: monash-theme.with(
  logo: monash-logo,
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

- Bullets receive Monash blue markers.
  - Nested bullets use a quieter grey marker.

=== Content Heading

Level-three headings receive a compact Monash blue accent.

#definition[Term][
  A definition can be placed directly inside a slide.
]

```
def mse(y, pred):
    return ((y - pred) ** 2).mean()
```
````

## Public API

- `monash-theme`
- `show-monash-frames`
- `monash-frame-style`
- `monash-accent-rule`
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

The default visual language is a restrained Monash Blue Line system: white
surfaces, charcoal typography, clear Monash blue rules, and the official logo
supplied by the template. Decorative motif graphics and the `Ancora Imparo`
microbrand are not shown by default. Monash red is not used in the default
theme.

Code blocks use the locked Typst Universe package `@preview/zebraw:0.6.1` and
continue to work through ordinary fenced raw blocks.
