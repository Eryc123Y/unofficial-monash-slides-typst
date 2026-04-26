# Monash-Inspired Design Notes

This package is an unofficial student template. It should not present itself as
an official Monash University asset.

## Visual Direction

- Use Monash blue as the dominant academic identity colour.
- Use red sparingly as an accent for warnings or emphasis.
- Keep slides clean, spacious, and left-to-right readable.
- Prefer restrained headers and footers over decorative page furniture.
- Do not bundle, redraw, stretch, recolour, crop, or otherwise modify official
  Monash logo assets.

## Current Package Interpretation

The template currently uses:

- `#006DAE` as the primary blue.
- `#DF0021` as the red accent.
- neutral greys for body/footer contrast.
- a user-supplied `logo` slot instead of bundled official marks.
- a grey tertiary footer/progress colour so red remains a limited accent.

## Logo SVG Notes

The official Monash website exposes an SVG path for `monash-logo-mono.svg`, but
direct automated download may be blocked. Wikimedia Commons mirrors a
`Monash University logo.svg` file sourced from that official URL and marks it as
simple geometry/public domain while also warning that it may be trademarked.

Do not vendor that SVG into this package by default. If a user has the right to
use the mark, they can place their own SVG under `template/assets/` and pass:

```typst
#show: monash-theme.with(
  logo: image("assets/monash-logo.svg", height: 1.2em),
  ...
)
```

## References

- Monash Malaysia brand guide PDF: <https://www.monash.edu.my/__data/assets/pdf_file/0009/519165/monash-brandguide-2015.pdf>
- Monash core logo guidelines PDF: <https://www.monash.edu/__data/assets/pdf_file/0010/1656523/3.-CoreElements_Our-Logo.pdf>
- Wikimedia Commons mirror page: <https://commons.wikimedia.org/wiki/File:Monash_University_logo.svg>
- Wikimedia Commons SVG file: <https://upload.wikimedia.org/wikipedia/commons/7/7c/Monash_University_logo.svg>
