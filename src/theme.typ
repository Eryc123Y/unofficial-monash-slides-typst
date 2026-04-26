#import "@preview/touying:0.7.3": *
#import "@preview/zebraw:0.6.1": zebraw
#import "design.typ": *

#let monash-blue-light = monash-blue-wash

#let _display-logo(self, fallback: [Monash University], height: 1em) = {
  if self.info.logo != none {
    box(height: height, self.info.logo)
  } else {
    text(size: height, fill: monash-blue, weight: "bold", fallback)
  }
}

#let _page-number() = context [
  #utils.slide-counter.display() / #utils.last-slide-number
]

#let _monash-rule-line(
  lead: 5.2em,
  lead-paint: monash-blue,
  rest-paint: monash-grey,
  thickness: monash-header-separator,
) = grid(
  columns: (lead, 1fr),
  column-gutter: monash-space-sm,
  align: horizon,
  monash-accent-rule(width: lead, height: thickness, paint: lead-paint),
  line(length: 100%, stroke: (paint: rest-paint, thickness: .7pt)),
)

#let _monash-header(self) = {
  set align(top)

  let section = utils.display-current-heading(level: 1, style: auto)
  block(
    width: 100%,
    height: monash-masthead-height,
    inset: (x: monash-space-2xl),
    [
      #place(top + left, dy: .42em)[
        #text(
          size: monash-header-title-size,
          fill: monash-charcoal,
          weight: "bold",
          if section == none { [] } else { section },
        )
      ]
      #place(top + right, dy: .12em)[
        #_display-logo(self, height: monash-logo-content-height)
      ]
      #place(left + bottom)[#_monash-rule-line()]
    ],
  )
}

#let _monash-footer(self) = {
  set align(bottom)

  block(
    width: 100%,
    height: monash-footer-height,
    inset: (x: monash-space-2xl, bottom: monash-space-sm),
    [
      #place(right + bottom)[
        #text(size: monash-footer-size, fill: monash-muted, weight: "medium", _page-number())
      ]
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

#let _cover-meta(self, info) = (
  if info.author != none { info.author },
  if info.institution != none { info.institution },
  if info.date != none { utils.display-info-date(self) },
).filter(item => item != none)

#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
    config,
  )

  let info = self.info + args.named()
  let meta = _cover-meta(self, info)

  let body = block(
    width: 100%,
    height: 100%,
    fill: monash-paper,
    inset: (x: monash-space-2xl, y: monash-space-xl),
    [
      #place(top + right)[
        #_display-logo((info: info), height: monash-logo-cover-height)
      ]
      #align(left + horizon)[
        #block(width: 66%)[
          #monash-accent-rule(width: 6.2em, height: monash-rule-cover)
          #v(monash-space-lg)
          #text(size: monash-cover-title-size, fill: monash-charcoal, weight: "bold", info.title)
          #if info.subtitle != none {
            v(monash-space-sm)
            text(size: .92em, fill: monash-blue, weight: "medium", info.subtitle)
          }
          #v(monash-space-xl)
          #text(size: .56em, fill: monash-slate, meta.join([ | ]))
          #if extra != none {
            v(monash-space-sm)
            text(size: .5em, fill: monash-muted, extra)
          }
        ]
      ]
      #place(left + bottom)[
        #monash-accent-rule(width: 8.6em, height: monash-rule-cover)
      ]
    ],
  )

  touying-slide(self: self, body)
})

#let _section-number() = {
  context {
    let value = counter(heading).get().first() + 1
    if value < 10 { "0" + str(value) } else { str(value) }
  }
}

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
    inset: (x: monash-space-2xl, y: monash-space-xl),
    [
      #place(top + right)[
        #_display-logo(self, height: monash-logo-content-height)
      ]
      #align(left + horizon)[
        #grid(
          columns: (auto, 1fr),
          column-gutter: monash-space-xl,
          align: horizon,
          [
            #text(size: monash-section-number-size, fill: monash-blue, weight: "bold", _section-number())
          ],
          block(width: 70%)[
            #monash-accent-rule(width: 5.8em, height: monash-rule-cover)
            #v(monash-space-lg)
            #text(size: monash-section-title-size, fill: monash-charcoal, weight: "bold", section-title)
          ],
        )
      ]
    ],
  )

  touying-slide(self: self, body)
})

#let _monash-heading-three(it) = block(
  width: 100%,
  above: monash-space-sm,
  below: monash-space-xs,
  [
    #text(size: .78em, fill: monash-blue, weight: "bold", it.body)
    #v(.12em)
    #monash-accent-rule(width: 2.4em, height: monash-rule-thin)
  ],
)

#let _monash-heading-four(it) = block(
  above: monash-space-xs,
  below: monash-space-xs,
  [
    #monash-accent-rule(width: .62em, height: monash-rule-thin)
    #h(monash-space-xs)
    #text(size: .66em, fill: monash-charcoal, weight: "bold", it.body)
  ],
)

#let monash-theme(
  aspect-ratio: "16-9",
  logo: none,
  brand-motif: false,
  motto: none,
  progress-position: "none",
  progress-bar: false,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (top: monash-content-top-gap, bottom: 1.05em, x: 2.25em),
      header-ascent: 0em,
      footer-descent: 0em,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: _monash-new-section,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 23pt, fill: monash-charcoal)
        set par(leading: .74em)
        set list(
          indent: .74em,
          body-indent: .46em,
          marker: (
            text(fill: monash-blue, weight: "bold")[•],
            text(fill: monash-grey, weight: "bold")[–],
          ),
        )
        show heading.where(level: 3): _monash-heading-three
        show heading.where(level: 4): _monash-heading-four
        show strong: set text(fill: monash-blue-dark, weight: "bold")
        show raw: set text(size: .7em, fill: monash-charcoal)
        show: zebraw.with(
          background-color: monash-grey-light,
          highlight-color: monash-blue-wash,
          lang-color: monash-blue,
          lang-font-args: (size: .54em, weight: "bold"),
          radius: 2pt,
          inset: (x: monash-space-md, y: monash-space-sm),
          numbering: false,
        )
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
    config-store(
      align: top,
      brand-motif: brand-motif,
      motto: motto,
      progress-bar: progress-bar,
      progress-position: progress-position,
    ),
    config-info(logo: logo),
    ..args,
  )

  body
}
