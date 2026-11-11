// Each 0.1.x option name must panic with a message naming its replacement.
// scripts/check.sh compiles this file once per name with
// `--input legacy=<name>` and checks the error text.
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
  title-graphic-path: none,
)

#let theme-args = if name == "title-graphic-path" {
  (title-graphic: "background.png")
} else {
  ((name): values.at(name))
}

#show: monash-theme.with(..theme-args, config-info(title: [Legacy]))

#title-slide()
