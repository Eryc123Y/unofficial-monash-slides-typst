# Monash-Inspired Design Notes

This package is an unofficial student template. It should not present itself as
an official Monash University asset.

## Visual Direction

- Use Monash blue as the dominant academic identity colour.
- Do not use Monash red in the default presentation theme.
- Keep slides clean, spacious, and left-to-right readable.
- Prefer restrained headers and footers over decorative page furniture.
- Do not redraw, stretch, recolour, crop, or otherwise modify Monash logo
  assets.

## Current Package Interpretation

The template currently uses:

- `#006DAE` as the primary blue.
- neutral greys for body/footer contrast.
- the bundled `template/assets/Monash_University_logo.svg` in the starter deck.
- a grey tertiary footer/progress colour so the theme remains quiet.

## Logo SVG Notes

The official Monash website exposes an SVG path for `monash-logo-mono.svg`, but
direct automated download may be blocked. Wikimedia Commons mirrors a
`Monash University logo.svg` file sourced from that official URL and marks it as
simple geometry/public domain while also warning that it may be trademarked.

The starter template vendors `Monash_University_logo.svg` because this package
is explicitly intended to ship with the Monash slide scaffold. Users can replace
that asset under `template/assets/` and pass:

```typst
#show: monash-theme.with(
  logo: image("assets/Monash_University_logo.svg", height: 1em),
  ...
)
```

## References

- Monash Malaysia brand guide PDF: <https://www.monash.edu.my/__data/assets/pdf_file/0009/519165/monash-brandguide-2015.pdf>
- Monash core logo guidelines PDF: <https://www.monash.edu/__data/assets/pdf_file/0010/1656523/3.-CoreElements_Our-Logo.pdf>
- Wikimedia Commons mirror page: <https://commons.wikimedia.org/wiki/File:Monash_University_logo.svg>
- Wikimedia Commons SVG file: <https://upload.wikimedia.org/wikipedia/commons/7/7c/Monash_University_logo.svg>
