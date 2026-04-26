# Monash-Inspired Design Notes

This package is an unofficial student template. It should not present itself as
an official Monash University asset.

## Visual Direction

- Use Monash blue as the dominant academic identity colour.
- Do not use Monash red in the default presentation theme.
- Keep slides clean, spacious, and left-to-right readable.
- Prefer restrained headers and footers over decorative page furniture.
- Prefer abstract campus elements drawn in Typst over bundled photography.
- Do not redraw, stretch, recolour, crop, or otherwise modify Monash logo
  assets.

## Current Package Interpretation

The template currently uses:

- `#006DAE` as the primary blue.
- neutral greys for body/footer contrast.
- the bundled `template/assets/Monash_University_logo.svg` in the starter deck.
- abstract facade and campus-grid motifs inspired by Monash campus architecture
  and wayfinding.
- a footer progress treatment that stays quiet and avoids full-width bars.
- the `Ancora Imparo` motto as optional microtype, not as a headline.

The template does not bundle campus photos by default. If a future version adds
an optional photo cover, it should keep the photograph user-supplied or document
the image licence and attribution next to the asset.

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
- Monash overview and motto: <https://www.monash.edu/about/who>
- Monash Learning and Teaching Building: <https://www.monash.edu/learning-teaching/inclusive-education/learning-spaces/ltb>
- Wikimedia Commons mirror page: <https://commons.wikimedia.org/wiki/File:Monash_University_logo.svg>
- Wikimedia Commons SVG file: <https://upload.wikimedia.org/wikipedia/commons/7/7c/Monash_University_logo.svg>
