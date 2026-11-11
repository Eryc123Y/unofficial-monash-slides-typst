#import "@preview/touying:0.8.0": *
#import "@preview/zebraw:0.6.3": zebraw
#import "design.typ": *
#import "options.typ": check-footer, check-options, check-unknown-options

#let _display-logo(self, fallback: [Monash University], height: 1em) = {
  if self.info.logo != none {
    box(height: height, self.info.logo)
  } else {
    text(size: height, fill: monash-blue, weight: "bold", fallback)
  }
}

#let _title-graphic(graphic) = {
  if graphic == auto {
    image(
      "../template/assets/monash-presentation/background/bg-02.png",
      width: 100%,
      height: 100%,
      fit: "cover",
    )
  } else if graphic != none {
    box(width: 100%, height: 100%, graphic)
  }
}

// Counting symbols of Typst numbering patterns. A pattern with one of them
// shows the current slide only; with two it receives (current, total).
#let _counting-symbols = regex("[1aAiIαΑ一壹あいアイא가ㄱ*١۱१১ক①⓵]")

#let _slide-number(self) = context {
  let pattern = self.store.slide-numbering
  let current = utils.slide-counter.get().first()
  let total = utils.last-slide-counter.final().first()
  if type(pattern) == function {
    pattern(current, total)
  } else if pattern.matches(_counting-symbols).len() < 2 {
    numbering(pattern, current)
  } else {
    numbering(pattern, current, total)
  }
}

#let _title-bar(label) = {
  place(
    top + left,
    dx: -monash-page-margin-x,
    dy: -monash-page-margin-top,
    rect(
      width: 100% + 2 * monash-page-margin-x,
      height: monash-title-bar-height,
      fill: monash-blue,
      inset: (x: monash-page-margin-x - .2cm, y: .45cm),
    )[
      #set text(fill: white, size: monash-title-bar-font-size, weight: "bold")
      #label
    ],
  )
  v(monash-title-bar-height - monash-page-margin-top + .75cm)
}

#let _monash-footer(self) = {
  set align(bottom)
  block(width: 100%, height: monash-footer-height)[
    #place(bottom + left, dx: -monash-page-margin-x)[
      #rect(width: 100% + 2 * monash-page-margin-x, height: 2pt, fill: monash-grey-soft)
    ]
    #place(bottom + left, dx: -monash-page-margin-x)[
      #box(width: 100% + 2 * monash-page-margin-x)[
        #components.progress-bar(height: 2pt, self.store.accent-color, monash-grey-soft)
      ]
    ]
    #place(bottom + right)[
      #move(dx: -.15cm, dy: -.16cm)[
        #if self.store.slide-numbering != none {
          text(fill: monash-grey, size: monash-footer-size, _slide-number(self))
        }
      ]
    ]
  ]
}

/// Monash-inspired Touying content slide.
///
/// This is installed as the default slide function by `monash-theme`. Use it
/// directly only when a deck needs manual Touying slide control.
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

  let new-setting = body => {
    _title-bar(utils.display-current-heading(depth: self.slide-level))
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

#let _cover-meta-block(self, info, title-color, fontsize) = {
  let institution = if info.institution != none { info.institution } else { none }
  let date = if info.date != none { utils.display-info-date(self) } else { none }

  block(width: 100%)[
    #if info.author != none {
      text(fill: title-color, size: fontsize * 1.05, weight: "regular", info.author)
    }
    #if institution != none or date != none {
      if info.author != none { v(.18cm) }
      text(size: fontsize * .82, fill: monash-dark-grey)[
        #if institution != none { institution }
        #if institution != none and date != none {
          text(fill: monash-grey)[ | ]
        }
        #if date != none { date }
      ]
    }
  ]
}

#let _section-number(location, level: 1) = context {
  let number = 1
  for (index, item) in query(heading.where(level: level)).enumerate() {
    if item.location() == location {
      number = index + 1
    }
  }
  str(number)
}

#let _monash-outline-entry(self, it, current: true, alpha: 100%, large: false) = {
  let fill = if current { monash-blue } else { monash-muted.transparentize(alpha) }
  let accent = self.store.accent-color
  let number-fill = if current { accent } else { accent.transparentize(alpha) }
  let number-color = if current { white } else { white.transparentize(alpha) }
  let title = utils.short-heading(self: self, it.element)
  let number-size = if large { 1em } else { .78em }
  let title-size = if large { 1.1em } else { .92em }

  link(
    it.element.location(),
    box(width: 100%)[
      #grid(
        columns: (2.2em, 1fr),
        column-gutter: .7em,
        align: (center + horizon, left + horizon),
        box(
          width: 1.85em,
          height: 1.45em,
          fill: number-fill,
          baseline: 18%,
          text(size: number-size, fill: number-color, weight: "bold")[
            #_section-number(it.element.location(), level: it.level)
          ],
        ),
        text(
          size: title-size,
          fill: fill,
          weight: if current { "bold" } else { "regular" },
          title,
        ),
      )
    ],
  )
}

#let _monash-outline-slide(
  self,
  config: (:),
  title: utils.i18n-outline-title,
  depth: 1,
  spacing: .82em,
  ..args,
) = {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(footer: none),
    config,
  )

  touying-slide(self: self, {
    set std.align(top)
    block(width: 100%)[
      #text(size: self.store.font-size * 1.35, fill: monash-blue, weight: "bold")[
        #utils.call-or-display(self, title)
      ]
      #v(.15cm)
      #monash-accent-rule(width: 5.8em, height: 3pt, paint: self.store.accent-color)
    ]

    v(.9cm)

    block(width: 82%, inset: (left: .35cm))[
      #set par(leading: .62em)
      #components.custom-progressive-outline(
        self: self,
        level: none,
        depth: depth,
        numbered: (false,),
        vspace: (spacing,),
        title: none,
        show-current: (level, it) => _monash-outline-entry(self, it),
        ..args,
      )
    ]
  })
}

/// Creates the title slide for a Monash-inspired Touying deck.
///
/// The slide uses the configured `title-graphic`, title metadata, author,
/// institution, and date. Extra content can be placed below the metadata.
/// By default, it also creates an outline slide immediately after the
/// title. Set `outline: false` in `monash-theme.with(...)` to disable it.
#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let title-color = self.store.title-color
  let titlefontsize = self.store.title-font-size
  let fontsize = self.store.font-size

  let title-self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em, header: none, footer: none),
    config,
  )

  touying-slide(self: title-self, {
    place(top + left)[
      #_title-graphic(self.store.title-graphic)
    ]
    place(top + left, dx: 1.0cm, dy: 4.8cm)[
      #block(width: 65%)[
        #set text(fill: title-color, size: titlefontsize, weight: "bold")
        #set par(leading: .8em)
        #info.title
        #if info.subtitle != none {
          linebreak()
          text(size: titlefontsize * .65, weight: "regular")[#info.subtitle]
        }
      ]
    ]
    place(top + left, dx: 1.0cm, dy: 11.05cm)[
      #block(width: 60%)[
        #_cover-meta-block(self, info, title-color, fontsize)
        #if extra != none {
          v(.2cm)
          text(size: fontsize * .75, fill: monash-dark-grey, extra)
        }
      ]
    ]
  })

  if self.store.outline {
    _monash-outline-slide(self)
  }
})

#let _monash-new-section(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(footer: none),
    config,
  )

  let section-title = utils.display-current-heading(level: level, numbered: false)
  touying-slide(self: self, {
    set std.align(horizon)
    grid(
      columns: (1fr, 2.35fr),
      column-gutter: .72cm,
      align: (right + horizon, left + horizon),
      [
        #context {
          let loc = utils.current-heading(level: level).location()
          text(
            size: self.store.font-size * 4.1,
            fill: self.store.accent-color,
            weight: "bold",
            _section-number(loc, level: level),
          )
        }
      ],
      [
        #text(size: self.store.font-size * 2.05, fill: monash-blue, weight: "bold")[
          #section-title
        ]
      ],
    )

    v(.95cm)

    block(width: 78%, inset: (left: 13%))[
      #set par(leading: .58em)
      #components.custom-progressive-outline(
        self: self,
        level: level,
        depth: level,
        numbered: (false,),
        vspace: (.46em,),
        title: none,
        show-past: (level, it) => _monash-outline-entry(
          self,
          it,
          current: false,
          alpha: 58%,
        ),
        show-current: (level, it) => _monash-outline-entry(
          self,
          it,
          current: true,
          large: true,
        ),
        show-future: (level, it) => _monash-outline-entry(
          self,
          it,
          current: false,
          alpha: 58%,
        ),
      )
    ]
  })
})

#let _monash-heading-three(it) = {
  v(1em, weak: true)
  text(weight: "bold", fill: monash-blue, it.body)
  v(.7em, weak: true)
}

#let _font-rules(font, code-font, font-size, body) = {
  set text(size: font-size, fill: black)
  set text(font: font) if font != auto
  show raw: set text(font: code-font)
  body
}

/// Applies the Monash-inspired slide theme to a Touying deck.
///
/// Use this as the main document show rule. Every named parameter below is a
/// theme option; Touying settings are passed as positional `config-*(..)`
/// arguments.
///
/// ```typst
/// #show: monash-theme.with(
///   font: "Arial",
///   config-info(title: [Presentation Title]),
/// )
/// ```
#let monash-theme(
  /// Slide format: `"16-9"` or `"4-3"`.
  aspect-ratio: "16-9",
  /// Text font. `auto` keeps Typst's default font (or the one you set before
  /// the theme). `"Arial"` gives the Monash look where it is installed.
  font: auto,
  /// Font for code, as a family name or an array of names.
  code-font: "DejaVu Sans Mono",
  /// Body text size.
  font-size: monash-body-size,
  /// Title size on the title slide.
  title-font-size: monash-title-font-size,
  /// Colour of the title-slide text.
  title-color: black,
  /// Title-slide graphic: `auto` for the bundled background, `none` for the
  /// plain cover, or content such as `image(..)`.
  title-graphic: auto,
  /// Accent colour for list markers, strong text, progress, and numbers.
  accent-color: monash-orange,
  /// Logo content shown on the title slide and in the title bar.
  logo: none,
  /// Whether `#title-slide()` is followed by an outline slide.
  outline: true,
  /// Whether level-one headings create section divider slides.
  section-slides: true,
  /// Whether the footer shows the progress bar.
  progress-bar: true,
  /// Slide number pattern, or `none` to hide it. A pattern with two counting
  /// symbols such as `"1 / 1"` receives the current slide and the total.
  slide-numbering: "1",
  /// Footer text on the left: `none`, `auto` (short title and author), or
  /// content.
  footer: none,
  /// Touying `config-*(..)` values, then the document body.
  ..args,
  /// Document body transformed by the theme.
  body,
) = {
  check-unknown-options(args.named())
  check-options(
    aspect-ratio: aspect-ratio,
    font: font,
    code-font: code-font,
    font-size: font-size,
    title-font-size: title-font-size,
    title-color: title-color,
    title-graphic: title-graphic,
    accent-color: accent-color,
    logo: logo,
    outline: outline,
    section-slides: section-slides,
    progress-bar: progress-bar,
    slide-numbering: slide-numbering,
  )
  check-footer(footer)

  show: _font-rules.with(font, code-font, font-size)

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (x: monash-page-margin-x, top: monash-page-margin-top, bottom: monash-page-margin-bottom),
      footer: _monash-footer,
      footer-descent: 0%,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: if section-slides { _monash-new-section } else { none },
      slide-level: 2,
      show-strong-with-alert: false,
      zero-margin-footer: true,
    ),
    config-methods(
      init: (self: none, body) => {
        set par(justify: false, leading: .65em)
        set figure(placement: none)
        set list(
          marker: (
            box(width: .55em, height: .55em, baseline: -.05em, fill: accent-color),
            text(fill: accent-color.lighten(20%), size: .75em)[#sym.triangle.filled.r],
            text(fill: accent-color.lighten(20%), size: .75em)[#sym.star.filled],
          ),
          indent: 1.2em,
          body-indent: .6em,
        )
        set enum(
          full: true,
          numbering: (..nums) => box(
            fill: accent-color,
            inset: (x: 4pt, y: 2pt),
            text(fill: white, size: .72em, weight: "bold")[#nums.pos().last()],
          ),
          indent: 1.2em,
          body-indent: .8em,
        )
        show heading.where(level: 3): _monash-heading-three
        show heading.where(level: 4): set text(fill: monash-blue, weight: "bold")
        show strong: it => text(fill: accent-color, weight: "bold", it.body)
        show raw.where(block: false): it => box(
          fill: monash-blue-wash,
          stroke: (paint: monash-grey-soft, thickness: .45pt),
          radius: 1.5pt,
          inset: (x: .18em, y: .04em),
          baseline: .08em,
          text(size: .68em, fill: monash-blue-dark, weight: "medium", it),
        )
        show raw.where(block: true): set text(size: .72em, fill: monash-charcoal)
        show: zebraw.with(
          background-color: monash-grey-light,
          highlight-color: monash-blue-wash,
          lang: false,
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
      secondary: accent-color,
      tertiary: monash-grey,
      neutral-lightest: monash-paper,
      neutral-darkest: monash-charcoal,
    ),
    config-store(
      align: top,
      font-size: font-size,
      title-font-size: title-font-size,
      title-color: title-color,
      title-graphic: title-graphic,
      accent-color: accent-color,
      outline: outline,
      progress-bar: progress-bar,
      slide-numbering: slide-numbering,
      footer: footer,
    ),
    config-info(logo: logo),
    ..args,
  )

  body
}
