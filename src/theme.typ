#import "@preview/touying:0.7.3": *
#import "design.typ": *

#let monash-blue-light = monash-blue-soft

#let _info-value(info, key, fallback: none) = {
  if key in info and info.at(key) != none {
    info.at(key)
  } else {
    fallback
  }
}

#let _display-logo(self, fallback: [Monash University], height: 1em) = {
  if self.info.logo != none {
    box(height: height, self.info.logo)
  } else {
    text(size: height, fill: monash-blue, weight: "bold", fallback)
  }
}

#let _monash-header(self) = {
  set align(top)

  let heading = utils.display-current-heading(level: 2, style: auto)
  let section = utils.display-current-heading(level: 1, style: auto)
  block(
    width: 100%,
    inset: (x: monash-space-2xl, top: monash-space-md, bottom: monash-space-sm),
    [
      #grid(
        columns: (1fr, auto),
        column-gutter: monash-space-lg,
        align: horizon,
        [
          #text(size: monash-header-title-size, fill: monash-charcoal, weight: "bold", heading)
          #if section != none {
            h(monash-space-sm)
            text(size: monash-caption-size, fill: monash-muted, section)
          }
        ],
        _display-logo(self, height: monash-logo-content-height),
      )
      #v(monash-space-sm)
      #grid(
        columns: (5.2em, 1fr),
        column-gutter: monash-space-sm,
        align: horizon,
        monash-accent-rule(width: 5.2em, height: monash-rule-thin),
        line(length: 100%, stroke: (paint: monash-grey-soft, thickness: .35pt)),
      )
      #if self.store.progress-position == "header" and self.store.progress-bar {
        v(monash-space-xs)
        box(width: 7.5em)[
          #components.progress-bar(
            height: monash-rule-thin,
            monash-blue,
            monash-grey-soft,
          )
        ]
      } else {
        none
      }
    ],
  )
}

#let _footer-progress(self) = {
  if self.store.progress-position == "footer" and self.store.progress-bar {
    box(width: 7.2em)[
      #components.progress-bar(
        height: monash-rule-thin,
        monash-blue,
        monash-grey-soft,
      )
    ]
  } else { none }
}

#let _monash-footer(self) = {
  set align(bottom)
  set text(size: monash-footer-size, fill: monash-muted)

  block(
    width: 100%,
    inset: (x: monash-space-2xl, bottom: monash-space-md),
    [
      #grid(
        columns: (1fr, 1.35fr, 7.2em, auto),
        column-gutter: monash-space-md,
        align: horizon,
        {
          let title = if self.info.short-title == auto {
            self.info.title
          } else {
            self.info.short-title
          }
          if title != none {
            text(fill: monash-charcoal, weight: "medium", title)
          }
        },
        {
          let author = _info-value(self.info, "author", fallback: none)
          let institution = _info-value(self.info, "institution", fallback: [Monash University])
          if author != none {
            text(author)
            text(fill: monash-grey, " / ")
          }
          text(institution)
          if self.info.date != none {
            text(fill: monash-grey, " / ")
            text(utils.display-info-date(self))
          }
        },
        _footer-progress(self),
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
      inset: (x: monash-space-2xl, y: monash-space-xl),
      [
        #if self.store.brand-motif {
          place(right + horizon, dx: .25em)[
            #monash-facade-pattern(width: 8.8em, height: 72%)
          ]
          place(right + bottom, dx: -.6em, dy: -.15em)[
            #monash-campus-grid(width: 11em, height: 6.6em)
          ]
        }
        #place(top + right)[#_display-logo((info: info), height: monash-logo-cover-height)]
        #align(left + horizon)[
          #grid(
            columns: (auto, 1fr),
            column-gutter: monash-space-lg,
            align: horizon,
            monash-accent-rule(width: 7.9em, height: .12em, vertical: true),
            block(width: 64%)[
              #text(size: monash-cover-title-size, fill: monash-charcoal, weight: "bold", info.title)
              #if info.subtitle != none {
                v(monash-space-sm)
                text(size: .92em, fill: monash-blue, weight: "medium", info.subtitle)
              }
              #v(monash-space-lg)
              #monash-accent-rule(width: 4.6em, height: .11em)
              #v(monash-space-lg)
              #text(size: .56em, fill: monash-slate, meta.join([ | ]))
              #v(monash-space-xs)
              #monash-microbrand(motto: self.store.motto)
              #if extra != none {
                v(monash-space-sm)
                text(size: .5em, fill: monash-slate, extra)
              }
            ],
          )
        ]
      ],
    )
  }

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
      #if self.store.brand-motif {
        place(right + horizon, dx: .15em)[
          #monash-facade-pattern(width: 9.2em, height: 78%)
        ]
        place(left + bottom, dx: -.45em, dy: .05em)[
          #monash-campus-grid(width: 12em, height: 6.8em)
        ]
      }
      #place(top + right)[#_display-logo(self, height: monash-logo-content-height)]
      #align(left + horizon)[
        #grid(
          columns: (auto, auto, 1fr),
          column-gutter: monash-space-lg,
          align: horizon,
          text(size: 1.25em, fill: monash-blue, weight: "bold", _section-number()),
          monash-accent-rule(width: 5.4em, height: .11em, vertical: true),
          block(width: 68%)[
            #text(size: monash-section-title-size, fill: monash-charcoal, weight: "bold", section-title)
            #v(monash-space-md)
            #monash-microbrand(motto: self.store.motto)
          ],
        )
      ]
    ],
  )

  touying-slide(self: self, body)
})

#let monash-theme(
  aspect-ratio: "16-9",
  logo: none,
  brand-motif: true,
  motto: [Ancora Imparo],
  progress-position: "footer",
  progress-bar: true,
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (top: 3.45em, bottom: 1.35em, x: 2.25em),
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
        set list(indent: .8em, body-indent: .42em)
        show heading.where(level: 3): set text(fill: monash-blue)
        show heading.where(level: 4): set text(fill: monash-blue-dark)
        show strong: set text(fill: monash-blue-dark, weight: "bold")
        show raw: set text(size: .72em, fill: monash-charcoal)
        show raw.where(block: true): block.with(
          width: 100%,
          fill: monash-grey-light,
          stroke: .45pt + monash-grey-soft,
          radius: 2pt,
          inset: (x: monash-space-md, y: monash-space-sm),
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
