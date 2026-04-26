#import "@preview/touying:0.7.3": *

#let monash-blue = rgb("#006DAE")
#let monash-blue-dark = rgb("#00739D")
#let monash-blue-light = rgb("#EAF6FB")
#let monash-charcoal = rgb("#3C3C3C")
#let monash-slate = rgb("#505050")
#let monash-grey = rgb("#D1D3D4")
#let monash-grey-light = rgb("#F6F6F6")
#let monash-paper = rgb("#FFFFFF")

#let _info-value(info, key, fallback: none) = {
  if key in info and info.at(key) != none {
    info.at(key)
  } else {
    fallback
  }
}

#let _display-logo(self, fallback: [Monash University], height: 1em) = {
  if self.info.logo != none {
    self.info.logo
  } else {
    text(size: height, fill: monash-blue, weight: "bold", fallback)
  }
}

#let _monash-header(self) = {
  set align(top)
  set text(size: .42em)

  let heading = utils.display-current-heading(level: 2, style: auto)
  grid(
    rows: (auto, auto),
    if self.store.progress-bar {
      components.progress-bar(
        height: .08em,
        monash-blue,
        monash-grey,
      )
    } else {
      rect(width: 100%, height: .08em, fill: monash-grey, stroke: none)
    },
    block(
      width: 100%,
      inset: (x: 2em, top: .38em, bottom: .2em),
      grid(
        columns: (1fr, auto),
        align: horizon,
        text(fill: monash-slate, heading),
        box(height: 1em, _display-logo(self, height: .58em)),
      ),
    ),
  )
}

#let _monash-footer(self) = {
  set align(bottom)
  set text(size: .36em, fill: monash-slate)

  block(
    width: 100%,
    inset: (x: 2em, top: .12em, bottom: .34em),
    [
      #line(length: 100%, stroke: (paint: monash-grey, thickness: .35pt))
      #v(.22em)
      #grid(
        columns: (1fr, auto),
        align: horizon,
        {
          let left = _info-value(self.info, "institution", fallback: [Monash University])
          let title = if self.info.short-title == auto {
            self.info.title
          } else {
            self.info.short-title
          }
          text(left)
          if title != none {
            text(fill: monash-grey)[  |  ]
            text(title)
          }
        },
        context [
          #utils.slide-counter.display() / #utils.last-slide-number
        ],
      )
    ],
  )
}

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }

  self = utils.merge-dicts(
    self,
    config-page(
      header: _monash-header,
      footer: _monash-footer,
    ),
  )

  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }

  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
    config,
  )

  let info = self.info + args.named()
  let meta = (
    if info.author != none { info.author },
    if info.institution != none { info.institution },
    if info.date != none { utils.display-info-date(self) },
  ).filter(item => item != none)

  let body = {
    block(
      width: 100%,
      height: 100%,
      fill: monash-paper,
      inset: (x: 2.4em, y: 1.7em),
      [
        #place(top + right)[#_display-logo((info: info), height: .72em)]
        #align(left + horizon)[
          #block(width: 74%)[
            #text(size: 2.2em, fill: monash-charcoal, weight: "bold", info.title)
          ]
          #if info.subtitle != none {
            v(.65em)
            text(size: 1em, fill: monash-blue, info.subtitle)
          }
          #v(1em)
          #rect(width: 4.5em, height: .16em, fill: monash-blue, stroke: none)
          #v(1.15em)
          #text(size: .62em, fill: monash-slate, meta.join([  |  ]))
          #if extra != none {
            v(.55em)
            text(size: .55em, fill: monash-slate, extra)
          }
        ]
      ],
    )
  }

  touying-slide(self: self, body)
})

#let _monash-new-section(
  config: (:),
  level: 1,
  numbered: false,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
    config,
  )

  let section-title = utils.display-current-heading(level: level, numbered: numbered)

  let body = block(
    width: 100%,
    height: 100%,
    fill: monash-paper,
    inset: (x: 2.4em, y: 1.7em),
    [
      #place(top + right)[#_display-logo(self, height: .65em)]
      #align(left + horizon)[
        #text(size: .58em, fill: monash-slate, weight: "bold")[SECTION]
        #v(.6em)
        #block(width: 76%)[
          #text(size: 2.15em, fill: monash-charcoal, weight: "bold", section-title)
        ]
        #v(.8em)
        #rect(width: 5.8em, height: .14em, fill: monash-blue, stroke: none)
      ]
    ],
  )

  touying-slide(self: self, body)
})

#let monash-theme(
  aspect-ratio: "16-9",
  logo: none,
  progress-bar: true,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (top: 1.45em, bottom: 1.2em, x: 2em),
      header-ascent: 0em,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: _monash-new-section,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        show heading.where(level: 3): set text(fill: monash-blue)
        show heading.where(level: 4): set text(fill: monash-blue-dark)
        show strong: set text(fill: monash-blue-dark)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: monash-blue,
      secondary: monash-blue-dark,
      tertiary: monash-grey,
      neutral-lightest: monash-paper,
      neutral-darkest: monash-charcoal,
    ),
    config-store(align: top, progress-bar: progress-bar),
    config-info(logo: logo),
    ..args,
  )

  body
}
