// The light frame style, custom environments, frames without a number, and
// the end mark of a proof that closes with a display equation.
//   --input style=plain   the light style
//   --input counter=shared
#import "@preview/unofficial-monash-touying:1.1.0": *

#let claim = monash-frame("Claim", color: monash-teal)
#let open-problem = monash-frame("Open Problem", color: monash-blue-dark, numbered: false)

#show: monash-theme.with(outline: false, section-slides: false, config-info(title: [Frames]))
#show: show-monash-frames.with(
  style: sys.inputs.at("style", default: "filled"),
  shared-counter: sys.inputs.at("counter", default: "own") == "shared",
  extra: (claim, open-problem),
)

== Every environment

#theorem[Titled][Body.]
#example[Body.]
#exercise[Body.]
#warning[Body.]

== Custom environments

#claim[The first claim.] <first-claim>
#open-problem[Named][Never numbered.]
#claim[Titled][The second claim.]

See @first-claim.

== A custom environment on a slide with pauses

#claim[Counted once: this is Claim 3.]

#pause

#claim[And this is Claim 4.]

== Without a number

#theorem[Theorem 2.]
#theorem(numbered: false)[Classical][Quoted, not numbered.]
#theorem[Theorem 3, since the quoted one takes no number.]

== Proofs

#proof[Ends with text.]

#proof[Ends with a display equation, with the end mark on its line:
$ a^2 + b^2 = c^2. $]

#proof[Titled][A display equation in the middle
$ x = y $
does not move the end mark.]
