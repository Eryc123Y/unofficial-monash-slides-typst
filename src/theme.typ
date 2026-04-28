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

#let _title-color(color) = {
  if color == "white" {
    white
  } else if color == "black" {
    black
  } else {
    color
  }
}

#let _titlegraphic(graphic) = {
  if type(graphic) == str {
    image(graphic, width: 100%, height: 100%, fit: "cover")
  } else {
    box(width: 100%, height: 100%, graphic)
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

#let _is-visible-outline-heading(it) = {
  (
    not it.has("label")
      or str(it.label) not in (
      "touying:hidden",
      "touying:skip",
      "touying:unoutlined",
    )
  )
}

#let _heading-index(level, loc) = {
  query(heading.where(level: level))
    .filter(it => it.location().page() <= loc.page() and _is-visible-outline-heading(it))
    .len()
}

#let _monash-footer(self) = {
  set align(bottom)
  block(width: 100%, height: monash-footer-height)[
    #place(bottom + left, dx: -monash-page-margin-x)[
      #rect(width: 100% + 2 * monash-page-margin-x, height: 2pt, fill: monash-grey-soft)
    ]
    #place(bottom + left, dx: -monash-page-margin-x)[
      #box(width: 100% + 2 * monash-page-margin-x)[
        #components.progress-bar(height: 2pt, monash-orange, monash-grey-soft)
      ]
    ]
    #place(bottom + right)[
      #move(dx: -.15cm, dy: -.16cm)[
        #context text(
          fill: monash-grey,
          size: monash-footer-size,
          utils.slide-counter.display(),
        )
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

#let _render-monash-toc-slide(
  self,
  config: (:),
  title: [Table of Contents],
  numbering: true,
  ..args,
) = {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(footer: none),
    config,
  )

  touying-slide(self: self, {
    v(1.2cm)
    text(size: self.store.titlefontsize * .72, fill: monash-blue, weight: "bold", title)
    v(.45cm)
    monash-accent-rule(width: 4.4cm, height: 4pt, paint: monash-orange)
    v(.75cm)
    context {
      let sections = query(heading.where(level: 1))
        .filter(it => _is-visible-outline-heading(it))
      let count = sections.len()
      let col-count = if count <= 7 { 1 } else if count <= 16 { 2 } else if count <= 36 { 3 } else { 4 }
      let per-col = calc.ceil(count / col-count)
      let entry-size = if per-col <= 7 {
        self.store.fontsize * .9
      } else if per-col <= 12 {
        self.store.fontsize * .72
      } else if per-col <= 18 {
        self.store.fontsize * .56
      } else {
        self.store.fontsize * .44
      }
      let entry-gap = if per-col <= 7 { .46em } else if per-col <= 12 { .28em } else if per-col <= 18 { .14em } else { .04em }
      let number-inset = if per-col <= 12 { (x: 7pt, y: 4pt) } else if per-col <= 18 { (x: 5pt, y: 3pt) } else { (x: 4pt, y: 2pt) }

      grid(
        columns: (1fr,) * col-count,
        column-gutter: if col-count == 1 { 0em } else { 1.2cm },
        ..range(col-count).map(col => {
          let start = col * per-col
          let end = calc.min((col + 1) * per-col, count)
          block(width: 100%)[
            #for (idx, section) in sections.slice(start, end).enumerate() {
              let number = start + idx + 1
              block(width: 100%, below: entry-gap)[
                #grid(
                  columns: (auto, 1fr),
                  column-gutter: .58em,
                  align: horizon,
                  if numbering {
                    box(
                      fill: monash-orange,
                      inset: number-inset,
                      text(fill: white, weight: "bold", size: .72em, str(number)),
                    )
                  } else {
                    monash-accent-rule(width: .85em, height: 3pt, paint: monash-orange)
                  },
                  text(
                    fill: monash-charcoal,
                    size: entry-size,
                    weight: "bold",
                    link(section.location(), utils.short-heading(self: self, section)),
                  ),
                )
              ]
            }
          ]
        }),
      )
    }
  })
}

/// Creates the title slide for a Monash-inspired Touying deck.
///
/// The slide uses the configured `titlegraphic`, title metadata, author,
/// institution, and date. Extra content can be placed below the metadata. Set
/// `toc: true` in `monash-theme` or this function to insert an agenda slide
/// after the title.
#let title-slide(config: (:), extra: none, toc: auto, ..args) = touying-slide-wrapper(self => {
  let base-self = self
  let info = self.info + args.named()
  let title-color = _title-color(self.store.titlecolor)
  let titlefontsize = self.store.titlefontsize
  let fontsize = self.store.fontsize
  let show-toc = if toc == auto { self.store.toc } else { toc }

  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em, header: none, footer: none),
    config,
  )

  touying-slide(self: self, {
    place(top + left)[
      #_titlegraphic(self.store.titlegraphic)
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
  if show-toc {
    _render-monash-toc-slide(
      base-self,
      title: base-self.store.toc-title,
      numbering: base-self.store.toc-numbering,
    )
  }
})

#let _section-number-box(level: 1) = {
  context {
    let current-heading = utils.current-heading(level: level, hierachical: false)
    if current-heading != none {
      let value = _heading-index(level, current-heading.location())
      box(
        fill: monash-orange,
        inset: (x: 8pt, y: 5pt),
        baseline: 20%,
        text(fill: white, weight: "bold", str(value)),
      )
    }
  }
}

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
    v(2.1cm)
    block(width: 82%)[
      #if numbered {
        text(size: .78em, fill: monash-orange, weight: "bold")[
          Section #_section-number-box(level: level)
        ]
        v(.45cm)
      }
      #text(size: self.store.titlefontsize * .95, fill: monash-blue, weight: "bold")[
        #section-title
      ]
      #v(.55cm)
      #monash-accent-rule(width: 4.4cm, height: 4pt, paint: monash-orange)
    ]
  })
})

/// Creates a Monash-inspired table-of-contents slide.
///
/// Use `toc: true` in `monash-theme` to insert this automatically after the
/// title slide, or call `#toc-slide()` manually when the table of contents
/// should appear elsewhere. The slide lists level-one headings and automatically
/// uses up to three columns for long decks.
#let toc-slide(
  config: (:),
  title: auto,
  numbering: auto,
  ..args,
) = touying-slide-wrapper(self => {
  _render-monash-toc-slide(
    self,
    config: config,
    title: if title == auto { self.store.toc-title } else { title },
    numbering: if numbering == auto { self.store.toc-numbering } else { numbering },
    ..args,
  )
})

#let _monash-heading-three(it) = {
  v(1em, weak: true)
  text(weight: "bold", fill: monash-blue, it.body)
  v(.7em, weak: true)
}

/// Applies the Monash-inspired slide theme to a Touying deck.
///
/// Use this as the main document show rule. It keeps Touying as the authoring
/// model while applying Monash title bars, footer progress, text styles,
/// inline code styling, and light `zebraw` code blocks.
///
/// ```typst
/// #show: monash-theme.with(
///   config-info(title: [Presentation Title]),
/// )
/// ```
#let monash-theme(
  /// Touying aspect ratio. Defaults to widescreen slides.
  aspect-ratio: "16-9",
  /// Optional logo content shown by the theme.
  logo: none,
  /// Title-slide background image path or content.
  titlegraphic: "../template/assets/monash-presentation/background/bg-02.png",
  /// Title text colour. Accepts `black`, `white`, or a colour value.
  titlecolor: black,
  /// Main title font size.
  titlefontsize: monash-title-font-size,
  /// Base slide font size.
  fontsize: monash-body-size,
  /// Reserved brand motif switch for compatibility with the template surface.
  brand-motif: false,
  /// Optional motto value stored for future theme extensions.
  motto: none,
  /// Progress indicator location. The current theme uses the footer.
  progress-position: "footer",
  /// Whether to show the footer progress bar.
  progress-bar: true,
  /// Whether `title-slide` inserts a table-of-contents slide afterwards.
  toc: false,
  /// Title used by the table-of-contents slide.
  toc-title: [Table of Contents],
  /// Whether top-level table-of-contents entries show section numbers.
  toc-numbering: true,
  /// Whether level-one headings create section divider slides.
  section-slides: true,
  ..args,
  /// Document body transformed by the theme.
  body,
) = {
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
      receive-body-for-new-section-slide-fn: false,
      slide-level: 2,
      show-strong-with-alert: false,
      zero-margin-footer: true,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(font: "Arial", size: fontsize, fill: black)
        set par(justify: false, leading: .65em)
        set figure(placement: none)
        set list(
          marker: (
            box(width: .55em, height: .55em, baseline: -.05em, fill: monash-orange),
            text(fill: monash-orange.lighten(20%), size: .75em)[#sym.triangle.filled.r],
            text(fill: monash-orange.lighten(20%), size: .75em)[#sym.star.filled],
          ),
          indent: 1.2em,
          body-indent: .6em,
        )
        set enum(
          full: true,
          numbering: (..nums) => box(
            fill: monash-orange,
            inset: (x: 4pt, y: 2pt),
            text(fill: white, size: .72em, weight: "bold", nums.pos().last()),
          ),
          indent: 1.2em,
          body-indent: .8em,
        )
        show heading.where(level: 3): _monash-heading-three
        show heading.where(level: 4): set text(fill: monash-blue, weight: "bold")
        show strong: it => text(fill: monash-orange, weight: "bold", it.body)
        show raw.where(block: false): it => box(
          fill: monash-blue-wash,
          stroke: (paint: monash-grey-soft, thickness: .45pt),
          radius: 1.5pt,
          inset: (x: .18em, y: .04em),
          baseline: .08em,
          text(
            font: ("Source Code Pro", "DejaVu Sans Mono"),
            size: .68em,
            fill: monash-blue-dark,
            weight: "medium",
            it,
          ),
        )
        show raw.where(block: true): set text(
          font: ("Source Code Pro", "DejaVu Sans Mono"),
          size: .72em,
          fill: monash-charcoal,
        )
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
      secondary: monash-orange,
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
      toc: toc,
      toc-title: toc-title,
      toc-numbering: toc-numbering,
      titlegraphic: titlegraphic,
      titlecolor: titlecolor,
      titlefontsize: titlefontsize,
      fontsize: fontsize,
    ),
    config-info(logo: logo),
    ..args,
  )

  body
}
