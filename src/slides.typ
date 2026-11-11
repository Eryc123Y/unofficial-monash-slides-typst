// Content slide.

#import "@preview/touying:0.8.0": touying-slide, touying-slide-wrapper
#import "chrome.typ": title-bar-spacer
#import "appendix.typ": appendix-marker

/// Content slide with the Monash title bar and footer.
///
/// Level-two headings create these slides automatically. Call it directly
/// for manual layouts, for example `#slide(composer: (1fr, 1fr))[A][B]`.
#let slide(
  /// Touying configuration for this slide.
  config: (:),
  /// Number of subslides; `auto` counts pauses.
  repeat: auto,
  /// Extra set and show rules for the body, as a function of the body.
  setting: body => body,
  /// Touying composer for several bodies, for example `(1fr, 1fr)`.
  composer: auto,
  /// Vertical and horizontal alignment of the body. Defaults to `top`.
  align: auto,
  /// Slide bodies.
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let new-setting = body => {
    appendix-marker(self)
    title-bar-spacer(self)
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
