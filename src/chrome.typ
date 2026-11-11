// Page furniture of content slides: the title bar in the page header, the
// footer with slide number and progress bar, and the bounded logo.

#import "@preview/touying:0.8.0": components, utils
#import "design.typ": *

/// Scales `logo` down so it is at most `max-height` tall. Needs no context.
#let bounded-logo(logo, max-height) = context {
  let size = measure(logo)
  if size.height <= max-height {
    logo
  } else {
    scale(max-height / size.height * 100%, reflow: true, logo)
  }
}

#let _bar-min-height(self) = self.store.font-size * bar-height-factor
#let _bar-inset-y(self) = self.store.font-size * .4
#let _logo-height(self) = _bar-min-height(self) - 2 * _bar-inset-y(self)

// The slide heading shown in the bar, or `none`. Needs context.
#let _bar-heading(self) = {
  let it = utils.current-heading(depth: self.slide-level)
  if it != none { it.body }
}

// The title bar at its natural height and its text size. Needs context.
#let _bar-layout(self) = {
  let body = _bar-heading(self)
  let logo = self.info.at("logo", default: none)
  let logo-box = if logo != none {
    box(bounded-logo(logo, _logo-height(self)))
  }
  let logo-width = if logo-box != none { measure(logo-box).width + self.store.font-size } else { 0pt }
  let available = page.width - 2 * page-margin-x - logo-width
  let full-size = self.store.font-size * bar-text-factor
  let natural = measure(text(size: full-size, weight: "bold", body)).width
  let ratio = if natural <= available { 1 } else {
    calc.max(bar-min-text-ratio, available / natural)
  }
  let content = grid(
    columns: (1fr, auto),
    column-gutter: if logo-box != none { self.store.font-size } else { 0pt },
    align: (left + horizon, right + horizon),
    {
      set par(leading: .35em)
      text(size: full-size * ratio, weight: "bold", fill: white, body)
    },
    logo-box,
  )
  let inner = block(
    width: page.width,
    inset: (x: page-margin-x, y: _bar-inset-y(self)),
    content,
  )
  let height = calc.max(_bar-min-height(self), measure(inner).height)
  (inner: inner, height: height)
}

/// Page header of content slides: a full-width Monash blue bar holding the
/// current slide heading. A heading that is too wide first shrinks (down to
/// 75%) and then wraps; the bar grows to fit.
#let title-bar(self) = context {
  let bar = _bar-layout(self)
  place(top + left, block(
    width: 100%,
    height: bar.height,
    fill: monash-blue,
    align(horizon, bar.inner),
  ))
}

/// Top margin of content slides: room for a one-line title bar plus a gap.
#let content-margin-top(self) = (
  _bar-min-height(self) + self.store.font-size * bar-gap-factor
)

/// Flow spacing that keeps the body below a title bar taller than one line.
#let title-bar-spacer(self) = context {
  let extra = _bar-layout(self).height - _bar-min-height(self)
  if extra > 0pt { v(extra) }
}

// Counting symbols of Typst numbering patterns. A pattern with one of them
// shows the current slide only; with two it receives (current, total).
#let _counting-symbols = regex("[1aAiIαΑ一壹あいアイא가ㄱ*١۱१১ক①⓵]")

/// The formatted slide number. In the appendix only the current number is
/// shown, because the total counts main slides only. Needs no context.
#let slide-number(self) = context {
  let pattern = self.store.slide-numbering
  let current = utils.slide-counter.get().first()
  let total = utils.last-slide-counter.final().first()
  let appendix = self.at("appendix", default: false)
  if type(pattern) == function {
    pattern(current, total)
  } else if appendix or pattern.matches(_counting-symbols).len() < 2 {
    numbering(pattern, current)
  } else {
    numbering(pattern, current, total)
  }
}

/// Bottom margin of content slides, which holds the footer.
#let content-margin-bottom(self) = self.store.font-size * footer-height-factor

#let _footer-text(self) = {
  let footer = self.store.footer
  if footer == auto {
    let info = self.info
    let title = if info.short-title != auto { info.short-title } else { info.title }
    let parts = (title, info.author).filter(it => it not in (none, []))
    parts.join[#h(.6em)#sym.dot.c#h(.6em)]
  } else {
    footer
  }
}

/// Footer of content slides: optional text on the left, the slide number on
/// the right, and the progress bar along the bottom edge.
#let footer(self) = {
  let line = block(
    width: 100%,
    inset: (x: page-margin-x),
    grid(
      columns: (1fr, auto),
      align: (left + bottom, right + bottom),
      text(size: .5em, fill: monash-dark-grey, _footer-text(self)),
      if self.store.slide-numbering != none {
        text(size: .5em, fill: monash-grey, slide-number(self))
      },
    ),
  )
  let bar = if self.store.progress-bar {
    components.progress-bar(
      height: progress-height,
      self.store.accent-color,
      monash-grey-soft,
    )
  }
  block(width: 100%, height: 100%, {
    place(horizon + left, line)
    place(bottom + left, bar)
  })
}
