// Source of docs/preview/custom-cover.png: a cover with a logo, another
// accent colour, and authors with affiliations. The logo is a placeholder.
// Regenerate with `scripts/check.sh --thumbnail`.
#import "@preview/unofficial-monash-touying:1.1.0": *

#show: monash-theme.with(
  outline: false,
  accent-color: monash-teal,
  logo: image("../tests/assets/placeholder-wordmark.svg"),
  config-info(
    title: [A Talk with Several Authors],
    subtitle: [Your logo, your accent colour],
    author: (
      (name: "Ann Lee", affiliation: 1),
      (name: "Bo Chen", affiliation: (1, 2)),
      (name: "Carla Diaz", affiliation: 2),
    ),
    institution: ([Monash University], [University of Melbourne]),
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#title-slide()
