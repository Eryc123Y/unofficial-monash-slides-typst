// Each 0.1.x option name, and each invalid option value, must panic with a
// message naming the fix. scripts/check.sh compiles this file once per case
// with `--input legacy=<case>` and checks the error text.
#import "@preview/unofficial-monash-touying:1.0.0": *

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
)

#let theme-args = if name in invalid { invalid.at(name) } else {
  ((name): values.at(name))
}

#show: monash-theme.with(..theme-args, config-info(title: [Legacy]))

#title-slide()
