#let monash-blue = rgb("#006DAE")
#let monash-blue-dark = rgb("#005C91")
#let monash-teal = rgb("#007C89")
#let monash-teal-muted = rgb("#4F8F91")
#let monash-blue-grey = rgb("#557A95")
#let monash-charcoal = rgb("#3C3C3C")
#let monash-slate = rgb("#505050")
#let monash-muted = rgb("#787878")
#let monash-grey = rgb("#D1D3D4")
#let monash-grey-soft = rgb("#E7E8EA")
#let monash-grey-light = rgb("#F7F8F9")
#let monash-blue-wash = rgb("#F3FAFD")
#let monash-paper = rgb("#FFFFFF")

#let monash-space-xs = .24em
#let monash-space-sm = .42em
#let monash-space-md = .72em
#let monash-space-lg = 1.05em
#let monash-space-xl = 1.55em
#let monash-space-2xl = 2.25em

#let monash-masthead-height = 2.28em
#let monash-content-top-gap = 3.05em
#let monash-footer-height = .82em

#let monash-header-title-size = .42em
#let monash-footer-size = .36em
#let monash-caption-size = .34em
#let monash-cover-title-size = 2.2em
#let monash-section-title-size = 2.0em
#let monash-section-number-size = 1.42em
#let monash-logo-cover-height = 1.25em
#let monash-logo-content-height = 1.25em

#let monash-rule-thin = .035em
#let monash-rule-hairline = .02em
#let monash-header-separator = .065em
#let monash-rule-strong = .14em
#let monash-rule-cover = .16em
#let monash-frame-rule = 2pt

#let monash-accent-rule(
  width: 4.7em,
  height: monash-rule-strong,
  vertical: false,
  paint: monash-blue,
) = rect(
  width: if vertical { height } else { width },
  height: if vertical { width } else { height },
  fill: paint,
  stroke: none,
  radius: height / 2,
)
