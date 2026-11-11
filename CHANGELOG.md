# Changelog

## 1.0.0

A general-purpose release with a stable, Typst-style API. Requires Typst
0.15.0 or newer.

### Breaking changes

- Options are renamed to kebab-case: `fontsize` → `font-size`,
  `titlefontsize` → `title-font-size`, `titlecolor` → `title-color`,
  `titlegraphic` → `title-graphic`, `toc` → `outline`. The old names stop
  with an error that names the replacement.
- `toc-args`, `brand-motif`, `motto`, and `progress-position` are removed.
- `title-graphic` no longer accepts a path string, because the path was
  resolved inside the package; pass `image(..)`.
- The default font is Typst's built-in font (`font: auto`) instead of Arial,
  so decks compile without warnings on every platform. Use `font: "Arial"`
  for the previous look.
- `note` and `warning` are no longer numbered.
- The package exports a fixed list of names instead of all of Touying.
- Unknown `monash-theme` options are an error.
- Dependencies: Touying 0.8.0 (was 0.7.3), frame-it 2.1.0 (was 2.0.0),
  zebraw 0.6.3.

### New

- Options `font`, `code-font`, `accent-color`, `section-slides`,
  `slide-numbering`, and `footer`.
- Slide kinds `outline-slide`, `focus-slide`, and `ending-slide`;
  `new-section-slide` is exported.
- Environments `proposition`, `assumption`, `example`, and `exercise`;
  `show-monash-frames(shared-counter: true)`; `#theorem[Body]` without a
  title; `#proof[Body]` and `#proof[Title][Body]`; references show the
  shared number, or the name alone when numbering is off.
- A plain cover drawn with shapes for `title-graphic: none`.
- Compact bibliographies that continue onto further slides, and support for
  Touying's `show-bibliography-as-footnote`.
- A speaker-note panel in theme colours.
- Four example decks, a test suite, and a CI workflow.

### Fixed

- A long title no longer overlaps the author block on the title slide.
- A long slide heading shrinks and wraps instead of being clipped.
- Paragraphs, lists, and equations inside frames no longer overlap.
- Footnotes sit above the footer.
- `progress-bar: false` and `logo` take effect.
- Appendix sections are lettered, left out of outlines, and not counted in
  the slide total.
- A frame on a slide with `#pause` is counted once.
- Long inline code breaks across lines instead of wrapping inside its box.
- Nested list levels have distinct markers and sizes; the slide number is
  larger and darker.

## 0.1.3

### Fixed

- Numbered lists render without a type error.
