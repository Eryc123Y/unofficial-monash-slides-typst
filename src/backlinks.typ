// Links in both directions. Every reference and `goto` leaves a marker
// naming its target, and the name of the target ("Theorem 1", "Table 2")
// is itself the link back, with nothing added to the slide.

#import "@preview/touying:0.8.0": utils
#import "design.typ": *

// A marker for a labelled target.
#let backref-marker(target) = [#metadata(str(target))<monash-backref>]

// The first place on another slide among `sources`, or `none`.
#let _first-elsewhere(sources) = {
  let own = utils.slide-counter.get()
  sources.find(source => utils.slide-counter.at(source) != own)
}

// `body` as a link to `source`. The label lets the theme turn the links
// off again.
#let _back(source, body) = if source == none { body } else {
  [#link(source, body)<monash-backlink>]
}

/// `body`, which names the target labelled `target`, as a link back to the
/// first other slide that points at that target. Without such a slide, or
/// with `monash-theme(backlinks: false)`, it is `body` unchanged.
#let back-link(target, body) = context {
  if target == none { return body }
  let markers = query(<monash-backref>).filter(it => it.value == str(target))
  _back(_first-elsewhere(markers.map(it => it.location())), body)
}

// Label of the figure being drawn, for content that cannot be handed it.
#let current-target = state("monash-backlink-target", none)

#let back-link-here(body) = context back-link(current-target.get(), body)

#let _label-of(it) = it.at("label", default: none)

// The "Table 1" of a caption links back.
#let _figure-rules(body) = {
  show figure.where(kind: image).or(figure.where(kind: table)).or(figure.where(kind: raw)): it => {
    let target = _label-of(it)
    if target == none { return it }
    show figure.caption: caption => {
      if caption.supplement == none or caption.numbering == none { return caption }
      let name = [#caption.supplement~#context caption.counter.display(caption.numbering)]
      block[#back-link(target, name)#caption.separator#caption.body]
    }
    it
  }
  body
}

// A labelled display equation links back as a whole.
#let _equation-rules(body) = {
  show math.equation.where(block: true): it => {
    let target = _label-of(it)
    if target == none { it } else { back-link(target, it) }
  }
  body
}

// The number of a bibliography entry links back to its first citation on
// another slide. Entries carry no key, so this works where their order is
// known: styles that number them in the order of first citation.
#let _citation-order-styles = ("ieee", "vancouver", "nlm-citation-sequence", "nature")

#let _entry-number(cell) = context {
  let citations = query(cite)
  let key = citations.map(it => it.key).dedup().at(cell.y, default: none)
  let sources = citations.filter(it => it.key == key).map(it => it.location())
  _back(_first-elsewhere(sources), cell)
}

#let _citation-rules(body) = {
  show bibliography: it => {
    if it.style not in _citation-order-styles or it.full { return it }
    // These styles set the entries in a grid: number, then entry.
    show grid.cell.where(x: 0): _entry-number
    it
  }
  body
}

/// Rules that record references and make their targets link back, for
/// every slide body.
#let backlink-rules(enabled, body) = {
  show <monash-backlink>: it => if enabled { it } else { it.body }
  show ref: it => if it.form == "normal" and it.element != none {
    it + backref-marker(it.target)
  } else { it }
  show: _figure-rules
  show: _equation-rules
  show: _citation-rules
  body
}

/// Marks a piece of text as a place to go to. `goto` with the same label
/// links to it, and the text links back to the slide that does.
///
/// ```typst
/// #anchor(<assumption>)[The key assumption] is that the data are i.i.d.
/// ```
#let anchor(
  /// A label such as `<assumption>`.
  target,
  /// The text at the place.
  body,
) = {
  assert(
    type(target) == label,
    message: "unofficial-monash-touying: use #anchor(<name>)[Text].",
  )
  [#metadata("monash-anchor")#target#back-link(target, body)]
}

/// A link to a place marked with `anchor`, or to any labelled element.
///
/// ```typst
/// #goto(<assumption>)[Recall the key assumption.]
/// ```
#let goto(
  /// The label to go to.
  target,
  /// The link text.
  body,
) = {
  assert(
    type(target) == label,
    message: "unofficial-monash-touying: use #goto(<name>)[Text].",
  )
  link(target, body)
  backref-marker(target)
}
