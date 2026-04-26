# Monash Student Slides

An unofficial Monash-style presentation package for Typst. It is intentionally
thin: Touying remains the slide authoring system, while this package supplies a
Monash theme aligned with the `quarto-monash/presentation` Typst template,
theorem-like environments styled with `frame-it`, and Monash-styled code blocks
powered by `zebraw`.

## Usage

````typst
#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "@preview/monash-student-slides:0.1.0": *

#let monash-logo = image("assets/Monash_University_logo.svg", height: 1.25em)
#let monash-titlegraphic = image(
  "assets/monash-presentation/background/bg-02.png",
  width: 100%,
  height: 100%,
  fit: "cover",
)

#show: monash-theme.with(
  logo: monash-logo,
  titlegraphic: monash-titlegraphic,
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

- Bullets receive Quarto Monash square markers.
  - Nested bullets use triangle markers.

=== Content Heading

Level-three headings use Monash blue bold text.

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

The default visual language follows the Typst implementation from
`quarto-monash/presentation`: a full-page title graphic, full-width Monash blue
slide title bars, orange square list markers, a light footer baseline, orange
footer progress, and a small grey slide number. The template vendors the
background and logo PNG assets used by that design under
`template/assets/monash-presentation/`.

Code blocks use the locked Typst Universe package `@preview/zebraw:0.6.1` and
continue to work through ordinary fenced raw blocks.

The starter deck keeps the local SVG logo available, while `titlegraphic`
defaults to `assets/monash-presentation/background/bg-02.png` for Quarto Monash
visual alignment.
