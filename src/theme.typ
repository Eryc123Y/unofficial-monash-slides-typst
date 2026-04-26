#import "@preview/touying:0.7.3": *
#import themes.university: *

// Monash-inspired palette. This package is unofficial and does not ship
// Monash logo assets; pass a user-provided logo as content if needed.
#let monash-blue = rgb("#006DAE")
#let monash-blue-dark = rgb("#004B7A")
#let monash-blue-light = rgb("#E6F2FA")
#let monash-red = rgb("#DF0021")
#let monash-charcoal = rgb("#3C3C3C")
#let monash-slate = rgb("#505050")
#let monash-paper = rgb("#FFFFFF")

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
    config-info(logo: logo),
    config-colors(
      primary: monash-blue,
      secondary: monash-blue-dark,
      tertiary: monash-red,
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
