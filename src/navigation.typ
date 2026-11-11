// Outline slide and section divider slides.

#import "@preview/touying:0.8.0": components, config-common, config-page, touying-slide, touying-slide-wrapper, utils
#import "design.typ": *
#import "slides.typ": hidden-heading
#import "appendix.typ": appendix-marker, in-appendix, section-label

// Page setup shared by the navigation slides: no title bar, no footer.
#let _plain-page(self) = config-page(
  header: none,
  footer: none,
  margin: (x: page-margin-x * 2, y: self.store.font-size * 1.6),
)

#let _number-box(self, label, current: true, alpha: 0%, large: false) = {
  let accent = self.store.accent-color
  box(
    width: 1.85em,
    height: 1.45em,
    fill: if current { accent } else { accent.transparentize(alpha) },
    baseline: 18%,
    align(center + horizon, text(
      size: if large { 1em } else { .78em },
      fill: if current { white } else { white.transparentize(alpha) },
      weight: "bold",
      label,
    )),
  )
}

// One outline entry: a filled number box and the section title. Appendix
// sections are left out of every outline.
#let _outline-entry(self, it, current: true, alpha: 0%, large: false) = context {
  let location = it.element.location()
  if in-appendix(location) { return }
  let fill = if current { monash-blue } else { monash-muted.transparentize(alpha) }
  let title = utils.short-heading(self: self, it.element)
  link(location, grid(
    columns: (2.2em, 1fr),
    column-gutter: .7em,
    align: (center + horizon, left + horizon),
    _number-box(
      self,
      section-label(location, level: it.level),
      current: current,
      alpha: alpha,
      large: large,
    ),
    text(
      size: if large { 1.1em } else { .92em },
      fill: fill,
      weight: if current { "bold" } else { "regular" },
      title,
    ),
  ))
}

#let _outline-body(self, title, depth) = {
  block(width: 100%, below: 1.4em, {
    text(size: 1.35em, fill: monash-blue, weight: "bold", utils.call-or-display(self, title))
    v(.3em)
    monash-accent-rule(width: 5.8em, height: 3pt, paint: self.store.accent-color)
  })
  block(width: 82%, inset: (left: .35cm), {
    set par(leading: .62em)
    components.custom-progressive-outline(
      self: self,
      level: none,
      depth: depth,
      numbered: (false,),
      title: none,
      show-current: (level, it) => _outline-entry(self, it),
    )
  })
}

/// Builds the outline slide for `self`. Used by `outline-slide` and by
/// `title-slide`, which emits one automatically.
#let outline-slide-fn(self, title: auto, depth: 1, config: (:)) = {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    _plain-page(self),
    config,
  )
  let title = if title == auto { utils.i18n-outline-title } else { title }
  touying-slide(self: self, {
    appendix-marker(self)
    hidden-heading(self, title)
    _outline-body(self, title, depth)
  })
}

/// Outline slide listing the main sections. Appendix sections are omitted.
#let outline-slide(
  /// Slide title. `auto` uses Touying's localised "Outline".
  title: auto,
  /// Deepest heading level listed.
  depth: 1,
  /// Touying configuration for this slide.
  config: (:),
) = touying-slide-wrapper(outline-slide-fn.with(
  title: title,
  depth: depth,
  config: config,
))

#let _section-heading(self, level) = context {
  let current = utils.current-heading(level: level)
  let label = if current != none { section-label(current.location(), level: level) }
  grid(
    columns: (1fr, 2.35fr),
    column-gutter: .72cm,
    align: (right + horizon, left + horizon),
    text(size: self.store.font-size * 4.1, fill: self.store.accent-color, weight: "bold", label),
    text(
      size: self.store.font-size * 2.05,
      fill: monash-blue,
      weight: "bold",
      utils.display-current-heading(level: level, numbered: false),
    ),
  )
}

#let _section-outline(self, level) = block(width: 78%, inset: (left: 13%), {
  set par(leading: .58em)
  let faded = (level, it) => _outline-entry(self, it, current: false, alpha: 58%)
  components.custom-progressive-outline(
    self: self,
    level: level,
    depth: level,
    numbered: (false,),
    title: none,
    show-past: faded,
    show-current: (level, it) => _outline-entry(self, it, large: true),
    show-future: faded,
  )
})

/// Section divider slide, created automatically for every level-one
/// heading unless `section-slides: false`. It shows the section number and
/// title above an outline that highlights the current section. Appendix
/// sections are lettered and show no outline.
#let new-section-slide(
  /// Touying configuration for this slide.
  config: (:),
  /// Heading level of the section.
  level: 1,
  /// Kept for Touying compatibility; the number is always shown.
  numbered: true,
  /// Content after the heading, when Touying passes it.
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    _plain-page(self),
    config,
  )
  let appendix = self.at("appendix", default: false)
  touying-slide(self: self, setting: std.align.with(horizon), {
    appendix-marker(self)
    _section-heading(self, level)
    if not appendix {
      v(.95cm)
      _section-outline(self, level)
    }
    body
  })
})
