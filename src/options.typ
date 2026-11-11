// Validation of `monash-theme` options. Nothing in this file is exported.

#let _prefix = "unofficial-monash-touying: "

// Names accepted by 0.1.x that 1.0.0 renamed or removed, with the message a
// user sees when passing one of them.
#let _legacy-options = (
  fontsize: "`fontsize` was renamed to `font-size`.",
  titlefontsize: "`titlefontsize` was renamed to `title-font-size`.",
  titlecolor: "`titlecolor` was renamed to `title-color`.",
  titlegraphic: "`titlegraphic` was renamed to `title-graphic`.",
  toc: "`toc` was renamed to `outline`.",
  toc-args: (
    "`toc-args` was removed. Set `outline: false` and call "
      + "`#outline-slide(title: .., depth: ..)` where you want the outline."
  ),
  brand-motif: "`brand-motif` was removed; it never had an effect.",
  motto: "`motto` was removed; it never had an effect.",
  progress-position: (
    "`progress-position` was removed; the progress bar is always at the "
      + "bottom. Use `progress-bar: false` to hide it."
  ),
)

#let _valid-options = (
  "aspect-ratio",
  "font",
  "code-font",
  "font-size",
  "title-font-size",
  "title-color",
  "title-graphic",
  "accent-color",
  "logo",
  "outline",
  "section-slides",
  "progress-bar",
  "slide-numbering",
  "footer",
)

/// Panics on any named argument that is not a `monash-theme` option, naming
/// the replacement for options that existed in 0.1.x.
#let check-unknown-options(named) = {
  for key in named.keys() {
    if key in _legacy-options {
      panic(_prefix + _legacy-options.at(key))
    }
    panic(
      _prefix
        + "unknown option `"
        + key
        + "`. Valid options are: "
        + _valid-options.join(", ")
        + ". Touying settings go in positional `config-*(..)` arguments.",
    )
  }
}

#let _expect(condition, message) = if not condition {
  panic(_prefix + message)
}

#let _is-font(value) = (
  type(value) == str
    or (
      type(value) == array
        and value.len() > 0
        and value.all(it => type(it) == str)
    )
)

/// Checks the types and values of the documented options.
#let check-options(
  aspect-ratio: none,
  font: none,
  code-font: none,
  font-size: none,
  title-font-size: none,
  title-color: none,
  title-graphic: none,
  accent-color: none,
  logo: none,
  outline: none,
  section-slides: none,
  progress-bar: none,
  slide-numbering: none,
) = {
  _expect(
    aspect-ratio in ("16-9", "4-3"),
    "`aspect-ratio` must be \"16-9\" or \"4-3\", got " + repr(aspect-ratio) + ".",
  )
  _expect(
    font == auto or _is-font(font),
    "`font` must be `auto`, a font family name, or an array of names.",
  )
  _expect(
    _is-font(code-font),
    "`code-font` must be a font family name or an array of names.",
  )
  _expect(type(font-size) == length, "`font-size` must be a length such as `22pt`.")
  _expect(
    type(title-font-size) == length,
    "`title-font-size` must be a length such as `36pt`.",
  )
  _expect(type(title-color) == color, "`title-color` must be a color.")
  _expect(
    type(title-graphic) != str,
    "`title-graphic` no longer accepts a path, because a path is resolved "
      + "inside the package rather than your project. Pass "
      + "`title-graphic: image(\"your-file.png\", width: 100%, height: 100%, fit: \"cover\")` instead.",
  )
  _expect(
    title-graphic in (auto, none) or type(title-graphic) == content,
    "`title-graphic` must be `auto`, `none`, or content such as `image(..)`.",
  )
  _expect(type(accent-color) == color, "`accent-color` must be a color.")
  _expect(
    logo == none or type(logo) == content,
    "`logo` must be `none` or content such as `image(..)`.",
  )
  _expect(type(outline) == bool, "`outline` must be `true` or `false`.")
  _expect(type(section-slides) == bool, "`section-slides` must be `true` or `false`.")
  _expect(type(progress-bar) == bool, "`progress-bar` must be `true` or `false`.")
  _expect(
    slide-numbering == none or type(slide-numbering) in (str, function),
    "`slide-numbering` must be `none` or a numbering pattern such as \"1\" or \"1 / 1\".",
  )
}

/// Checks the `footer` option separately so the error names it precisely.
#let check-footer(footer) = _expect(
  footer in (none, auto) or type(footer) in (content, str),
  "`footer` must be `none`, `auto`, or content.",
)
