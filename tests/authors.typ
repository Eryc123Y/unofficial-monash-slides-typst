// Authors with affiliations on the cover, and the names alone in the footer.
//   --input aspect=4-3   narrow format
#import "@preview/unofficial-monash-touying:1.1.0": *

#show: monash-theme.with(
  aspect-ratio: sys.inputs.at("aspect", default: "16-9"),
  outline: false,
  footer: auto,
  math-font: "New Computer Modern Math",
  config-info(
    title: [Authors and Affiliations],
    author: (
      (name: "Ann Lee", affiliation: 1),
      (name: [Bo Chen], affiliation: (1, 2)),
      (name: "Carla Diaz", affiliation: 3),
    ),
    institution: (
      [Monash University],
      [University of Melbourne],
      [CSIRO Data61],
    ),
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

// Three authors, three numbered institutions, the date on its own line.
#title-slide()

// One institution: no numbers, and the usual "institution | date" line.
#title-slide(institution: [Monash University], author: ("Ann Lee", "Bo Chen"))

// Several institutions without affiliations: listed without numbers.
#title-slide(author: ("Ann Lee", "Bo Chen"))

// Many authors wrap; a name and its number stay together.
#title-slide(author: range(1, 9).map(i => (
  name: "Author Number " + str(i),
  affiliation: calc.rem(i, 3) + 1,
)))

== Footer and math font

The footer shows the names without numbers, and math uses the font set by
`math-font`: $integral_0^1 x^2 dif x = 1/3$.
