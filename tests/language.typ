// Labels follow the text language, and `labels:` overrides single ones.
//   --input lang=en|zh|zh-tw   language of the deck (default en); the
//                              Chinese runs need Noto Sans CJK SC
//   --input override=on        replace two labels by hand
#import "@preview/unofficial-monash-touying:1.1.0": *

#let lang = sys.inputs.at("lang", default: "en")
#let override = sys.inputs.at("override", default: "off") == "on"

#set text(lang: lang.slice(0, 2), region: if lang == "zh-tw" { "TW" } else { none })
#let cjk = if lang == "en" { () } else { ("Noto Sans CJK SC",) }

#show: monash-theme.with(
  font: ("Libertinus Serif",) + cjk,
  outline: false,
  config-info(title: [Language: #raw(lang)]),
)

#show: show-monash-frames.with(
  labels: if override { (theorem: "Thm", proof: [Beweis]) } else { (:) },
)

#title-slide()

== Numbered environments

#definition[Term][Body.]
#theorem[Banach][Body.] <thm>
#lemma[Body.]
#corollary[Body.]

A reference: @thm.

== More environments

#proposition[Body.]
#assumption[Body.]
#example[Body.]
#exercise[Body.]

== Unnumbered environments and proofs

#remark[Body.]
#note[Body.]
#warning[Body.]

#proof[Body.]
#proof[Sketch][Body.]

#ending-slide[Contact details.]
