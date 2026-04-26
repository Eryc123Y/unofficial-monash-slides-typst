#import "@preview/touying:0.7.3": *
#import themes.university: *

// Monash-inspired palette. This package is unofficial and does not ship
// Monash logo assets; pass a user-provided logo as content if needed.
// Public Monash digital brand references list these colour values.
#let monash-blue = rgb("#006DAE")
#let monash-blue-dark = rgb("#00739D")
#let monash-blue-light = rgb("#EAF6FB")
#let monash-red = rgb("#DF0021")
#let monash-charcoal = rgb("#3C3C3C")
#let monash-slate = rgb("#505050")
#let monash-grey = rgb("#D1D3D4")
#let monash-grey-light = rgb("#F6F6F6")
#let monash-paper = rgb("#FFFFFF")

#let _monash-section-break(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
    config,
  )

  let section-title = utils.display-current-heading(level: level, numbered: false)

  let slide-body = {
    grid(
      columns: (18%, 1fr),
      block(
        height: 100%,
        width: 100%,
        fill: monash-blue,
        [
          #place(bottom + left, dx: 1.25em, dy: -1.25em)[
            #text(size: .75em, fill: white)[MONASH]
          ]
          #place(top + left)[
            #rect(width: 100%, height: .25em, fill: monash-red, stroke: none)
          ]
        ],
      ),
      block(
        height: 100%,
        width: 100%,
        fill: white,
        inset: (left: 2.6em, right: 2.4em),
        align(left + horizon)[
          #text(size: .72em, fill: monash-red, weight: "bold")[SECTION]
          #v(.45em)
          #text(size: 2.6em, fill: monash-charcoal, weight: "bold", section-title)
          #v(.6em)
          #rect(width: 38%, height: .14em, fill: monash-blue, stroke: none)
        ],
      ),
    )
  }

  touying-slide(self: self, slide-body)
})

#let monash-theme(
  aspect-ratio: "16-9",
  logo: none,
  campus: none,
  progress-bar: true,
  ..args,
  body,
) = {
  let header-right = self => {
    let section = utils.display-current-heading(level: 1)
    if logo != none {
      box(section) + h(.35em) + logo
    } else {
      section
    }
  }

  let footer-a = self => {
    if campus != none {
      campus
    } else if self.info.institution != none {
      self.info.institution
    } else {
      [Monash University]
    }
  }

  let footer-b = self => {
    if self.info.short-title == auto {
      self.info.title
    } else {
      self.info.short-title
    }
  }

  show: university-theme.with(
    aspect-ratio: aspect-ratio,
    progress-bar: progress-bar,
    header-right: header-right,
    footer-a: footer-a,
    footer-b: footer-b,
    footer-columns: (24%, 1fr, 20%),
    config-info(logo: logo),
    config-common(new-section-slide-fn: _monash-section-break),
    config-colors(
      primary: monash-blue,
      secondary: monash-blue-dark,
      tertiary: monash-grey,
      neutral-lightest: monash-paper,
      neutral-darkest: monash-charcoal,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        show heading.where(level: 3): set text(fill: self.colors.primary)
        show heading.where(level: 4): set text(fill: self.colors.secondary)
        show strong: set text(fill: self.colors.secondary)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    ..args,
  )

  body
}
