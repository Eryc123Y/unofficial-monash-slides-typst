// Many sections: with up to 12 sections the outline slide and every section
// divider fit on one page each, in both formats. scripts/check.sh asserts
// the page count: 1 title + 1 outline + 12 x (divider + slide) = 26.
//   --input sections=<n>   number of sections (default 12)
//   --input aspect=4-3     narrow format
#import "@preview/unofficial-monash-touying:1.0.0": *

#let count = int(sys.inputs.at("sections", default: "12"))

#show: monash-theme.with(
  aspect-ratio: sys.inputs.at("aspect", default: "16-9"),
  config-info(title: [Many Sections], author: [Test Author]),
)

#title-slide()

#for n in range(1, count + 1) [
  = Section number #n with a moderately long name

  == Slide in section #n

  Content of section #n.
]
