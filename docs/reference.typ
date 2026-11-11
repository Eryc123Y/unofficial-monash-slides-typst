#import "@preview/tidy:0.4.3"
#import "@preview/unofficial-monash-touying:1.0.0" as monash

#set document(title: "Unofficial Monash Touying Reference")
#set page(paper: "a4", margin: 2cm)
#set text(size: 10pt)
#set par(justify: false, leading: .65em)

= Unofficial Monash Touying Reference

This reference is generated from the package's doc comments with `tidy`. The
package itself does not depend on `tidy`. See `README.md` for the user
manual, including the Touying names the package re-exports.

#let scope = (monash: monash)
#let section(title, ..files) = {
  let docs = tidy.parse-module(
    files.pos().map(file => read("../src/" + file)).join("\n"),
    name: title,
    scope: scope,
  )
  tidy.show-module(docs, style: tidy.styles.default, show-outline: false)
}

#section("Theme", "theme.typ")
#section("Slides", "cover.typ", "slides.typ", "navigation.typ")
#section("Environments", "frames.typ")
#section("Design helpers", "design.typ")
