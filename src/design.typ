#let monash-blue = rgb("#006DAE")
#let monash-blue-dark = rgb("#00739D")
#let monash-blue-soft = rgb("#E6F2F8")
#let monash-blue-wash = rgb("#F3FAFD")
#let monash-charcoal = rgb("#3C3C3C")
#let monash-slate = rgb("#505050")
#let monash-muted = rgb("#787878")
#let monash-grey = rgb("#D1D3D4")
#let monash-grey-soft = rgb("#E7E8EA")
#let monash-grey-light = rgb("#F7F8F9")
#let monash-paper = rgb("#FFFFFF")

#let monash-space-xs = .24em
#let monash-space-sm = .42em
#let monash-space-md = .72em
#let monash-space-lg = 1.05em
#let monash-space-xl = 1.55em
#let monash-space-2xl = 2.25em

#let monash-slide-title-size = 1.18em
#let monash-body-size = .78em
#let monash-caption-size = .34em
#let monash-header-title-size = .52em
#let monash-footer-size = .32em
#let monash-micro-size = .27em
#let monash-cover-title-size = 2.18em
#let monash-section-title-size = 2.05em
#let monash-logo-cover-height = 1.25em
#let monash-logo-content-height = 1.25em

#let monash-rule-thin = .035em
#let monash-rule-hairline = .02em
#let monash-header-separator = .065em
#let monash-rule-strong = .14em
#let monash-frame-rule = 1.8pt

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

#let monash-facade-pattern(
  width: 9.2em,
  height: 100%,
  accent: monash-blue,
) = block(
  width: width,
  height: height,
  [
    #place(left + top, dx: .1em)[#line(angle: 90deg, length: height, stroke: (paint: accent.transparentize(82%), thickness: .9pt))]
    #place(left + top, dx: 1.0em)[#line(angle: 90deg, length: height, stroke: (paint: monash-grey.transparentize(35%), thickness: .45pt))]
    #place(left + top, dx: 1.55em)[#line(angle: 90deg, length: height, stroke: (paint: accent.transparentize(72%), thickness: 1.1pt))]
    #place(left + top, dx: 2.45em)[#line(angle: 90deg, length: height, stroke: (paint: monash-grey.transparentize(48%), thickness: .45pt))]
    #place(left + top, dx: 3.15em)[#line(angle: 90deg, length: height, stroke: (paint: accent.transparentize(84%), thickness: .75pt))]
    #place(left + top, dx: 4.05em)[#line(angle: 90deg, length: height, stroke: (paint: monash-grey.transparentize(40%), thickness: .45pt))]
    #place(left + top, dx: 4.7em)[#line(angle: 90deg, length: height, stroke: (paint: accent.transparentize(68%), thickness: 1.15pt))]
    #place(left + top, dx: 5.7em)[#line(angle: 90deg, length: height, stroke: (paint: monash-grey.transparentize(50%), thickness: .45pt))]
    #place(left + top, dx: 6.35em)[#line(angle: 90deg, length: height, stroke: (paint: accent.transparentize(80%), thickness: .9pt))]
    #place(left + top, dx: 7.25em)[#line(angle: 90deg, length: height, stroke: (paint: monash-grey.transparentize(42%), thickness: .45pt))]
    #place(left + top, dx: 8.05em)[#line(angle: 90deg, length: height, stroke: (paint: accent.transparentize(74%), thickness: .95pt))]
    #place(left + top, dx: 8.75em)[#line(angle: 90deg, length: height, stroke: (paint: monash-grey.transparentize(52%), thickness: .45pt))]
  ],
)

#let monash-campus-grid(
  width: 10.5em,
  height: 6.5em,
) = block(
  width: width,
  height: height,
  [
    #place(left + top, dx: .35em, dy: .55em)[#line(length: width * .62, stroke: (paint: monash-grey.transparentize(60%), thickness: .45pt))]
    #place(left + top, dx: 1.1em, dy: 2.05em)[#line(length: width * .74, stroke: (paint: monash-blue.transparentize(86%), thickness: .65pt))]
    #place(left + top, dx: .2em, dy: 3.45em)[#line(length: width * .58, stroke: (paint: monash-grey.transparentize(58%), thickness: .45pt))]
    #place(left + top, dx: 2.0em, dy: 4.85em)[#line(length: width * .66, stroke: (paint: monash-grey.transparentize(66%), thickness: .45pt))]
    #place(left + top, dx: 1.0em, dy: .2em)[#line(angle: 90deg, length: height * .78, stroke: (paint: monash-grey.transparentize(65%), thickness: .45pt))]
    #place(left + top, dx: 3.2em, dy: .85em)[#line(angle: 90deg, length: height * .62, stroke: (paint: monash-blue.transparentize(88%), thickness: .6pt))]
    #place(left + top, dx: 5.3em, dy: .35em)[#line(angle: 90deg, length: height * .83, stroke: (paint: monash-grey.transparentize(60%), thickness: .45pt))]
    #place(left + top, dx: 7.6em, dy: 1.3em)[#line(angle: 90deg, length: height * .58, stroke: (paint: monash-grey.transparentize(68%), thickness: .45pt))]
    #place(left + top, dx: 3.05em, dy: 1.9em)[#circle(radius: .08em, fill: monash-blue.transparentize(70%), stroke: none)]
    #place(left + top, dx: 5.18em, dy: 3.37em)[#circle(radius: .07em, fill: monash-grey.transparentize(35%), stroke: none)]
    #place(left + top, dx: 7.45em, dy: 4.78em)[#circle(radius: .07em, fill: monash-blue.transparentize(78%), stroke: none)]
  ],
)

#let monash-microbrand(motto: [Ancora Imparo]) = {
  if motto != none {
    text(
      size: monash-micro-size,
      fill: monash-muted,
      weight: "bold",
      tracking: .06em,
      motto,
    )
  }
}
