# Monash Student Slides

An unofficial Monash-style presentation template package for Typst, built as a
thin wrapper around [Touying](https://typst.app/universe/package/touying/).

This package is not endorsed by Monash University. It does not bundle, redraw,
or modify official Monash logo assets. If you have permission to use an official
logo, pass it through the `logo` option yourself.

## Design Notes

The visual direction follows public Monash brand cues at a conservative level:
a blue-led academic palette, restrained red accent use, generous whitespace,
clear left-to-right hierarchy, and a quiet footer suitable for course and
research talks.

## Usage

```typst
#import "@preview/monash-student-slides:0.1.0": *
#import "@preview/touying:0.7.3": *

#show: monash-theme.with(
  campus: [Monash University Malaysia],
  config-info(
    title: [Presentation Title],
    subtitle: [Subtitle],
    author: [Your Name],
    institution: [Monash University],
    date: datetime.today(),
  ),
)

#title-slide()

= Section

== Slide Title

#info-block(title: [Context])[
  Slide content.
]
```

For local development, the template imports `../lib.typ` directly. Universe
users should import the package with `@preview/...` after publication.

## Development Harness

Run:

```sh
./scripts/check.sh
```

The harness compiles the template and example decks into `build/`.

## Included Helpers

- `monash-theme`
- `title-slide`
- `section-slide`
- `closing-slide`
- `two-column-slide`
- `equation-slide`
- `code-slide`
- `theorem-slide`
- `definition-slide`
- `proof-slide`
- `algorithm-slide`
- `info-block`
- `alert-block`
- `result-block`
- `metric-row`

## Brand Boundary

This is an unofficial student-oriented template. It uses a Monash-inspired
layout and palette, but it avoids shipping official marks. Keep any future logo
support opt-in and user supplied.

