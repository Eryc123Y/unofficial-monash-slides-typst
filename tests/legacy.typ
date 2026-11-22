// Each 0.1.x option name, and each invalid option value, must panic with a
// message naming the fix. scripts/check.sh compiles this file once per case
// with `--input legacy=<case>` and checks the error text.
#import "@preview/unofficial-monash-touying:1.1.0": *

#let name = sys.inputs.at("legacy", default: "fontsize")
#let values = (
  fontsize: 20pt,
  titlefontsize: 30pt,
  titlecolor: black,
  titlegraphic: none,
  toc: false,
  toc-args: (:),
  brand-motif: false,
  motto: none,
  progress-position: "footer",
)

// Invalid values of current options.
#let invalid = (
  title-graphic-path: (title-graphic: "background.png"),
  font-size-relative: (font-size: 1.2em),
  numbering-no-symbol: (slide-numbering: "-"),
  unknown-option: (colour: red),
  logo-bad-key: (logo: (corner: [Logo])),
  logo-bad-value: (logo: (cover: "logo.svg")),
  logo-bad-fill: (logo: (bar: [Logo], bar-fill: "white")),
  math-font-bad: (math-font: 12pt),
)

// Invalid values outside the theme options.
#let author = if name == "author-bad-affiliation" {
  ((name: "Ann Lee", affiliation: 2),)
} else { [Author] }
#let labels = if name == "labels-bad-key" { (theorm: "Thm") } else { (:) }

#let theme-args = if name in invalid { invalid.at(name) } else if name in values {
  ((name): values.at(name))
} else { (:) }

#show: monash-theme.with(
  ..theme-args,
  config-info(title: [Legacy], author: author, institution: [Monash University]),
)
#show: show-monash-frames.with(
  labels: labels,
  ..if name == "style-bad" { (style: "light") },
  ..if name == "extra-bad" { (extra: ("Claim",)) },
)

#title-slide()
