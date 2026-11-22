// Links in both directions. Every reference, `goto`, and citation leaves a
// marker naming its target; the target lists the other slides that point at
// it, each a link back to that slide.

#import "@preview/touying:0.8.0": utils
#import "design.typ": *

// A marker for a labelled target.
#let backref-marker(target) = [#metadata(str(target))<monash-backref>]

// "↩ 3, 7" for the places that point here, leaving out the current slide
// and listing a slide once however often it points here.
#let _links(sources, paint, size) = {
  let own = utils.slide-counter.get()
  let seen = ()
  let links = ()
  for source in sources {
    let slide = utils.slide-counter.at(source)
    if slide == own or slide in seen { continue }
    seen.push(slide)
    links.push(link(source, str(slide.first())))
  }
  if links.len() > 0 {
    text(size: size, fill: paint, weight: "regular", style: "normal")[#sym.arrow.l.hook~#links.join[, ]]
  }
}

/// The back links of the target labelled `target`, or nothing when no other
/// slide points at it. `monash-theme(backlinks: false)` hides them all.
#let backlinks(target, paint: monash-muted, size: .6em) = [#context {
  if target != none {
    let markers = query(<monash-backref>).filter(it => it.value == str(target))
    _links(markers.map(it => it.location()), paint, size)
  }
}<monash-backlinks>]

// Label of the figure being drawn, for content that cannot be handed it.
#let current-target = state("monash-backlink-target", none)

#let backlinks-here(paint: monash-muted, size: .6em) = context backlinks(
  current-target.get(),
  paint: paint,
  size: size,
)

#let _label-of(it) = it.at("label", default: none)

// Captions of images, tables, and code figures end with their back links.
#let _figure-rules(body) = {
  show figure.where(kind: image).or(figure.where(kind: table)).or(figure.where(kind: raw)): it => {
    let target = _label-of(it)
    if target == none { return it }
    show figure.caption: caption => block({
      if caption.supplement != none and caption.numbering != none {
        [#caption.supplement~#context caption.counter.display(caption.numbering)#caption.separator]
      }
      caption.body
      h(.5em)
      backlinks(target, size: .85em)
    })
    it
  }
  body
}

// A labelled display equation shows its back links under its number.
#let _equation-rules(body) = {
  show math.equation.where(block: true): it => {
    let target = _label-of(it)
    if target == none { return it }
    it
    place(right, dy: -.55em, backlinks(target))
  }
  body
}

// A bibliography entry lists the slides that cite it. Entries carry no
// key, so this works where the order of the entries is known: styles that
// number them in the order of first citation.
#let _citation-order-styles = ("ieee", "vancouver", "nlm-citation-sequence", "nature")

#let _entry-links(cell) = context {
  let citations = query(cite)
  let keys = citations.map(it => it.key).dedup()
  let key = keys.at(cell.y, default: none)
  let sources = citations.filter(it => it.key == key).map(it => it.location())
  [#cell#h(.5em)#box[#_links(sources, monash-muted, .9em)<monash-backlinks>]]
}

#let _citation-rules(body) = {
  show bibliography: it => {
    if it.style not in _citation-order-styles or it.full { return it }
    // These styles set the entries in a grid: number, then entry.
    show grid.cell.where(x: 1): _entry-links
    it
  }
  body
}

/// Rules that record references and show back links, for every slide body.
#let backlink-rules(enabled, body) = {
  show <monash-backlinks>: it => if enabled { it }
  show ref: it => if it.form == "normal" and it.element != none {
    it + backref-marker(it.target)
  } else { it }
  show: _figure-rules
  show: _equation-rules
  show: _citation-rules
  body
}

/// Marks a place to return to. Give it a label, and optionally the text to
/// show there; `goto` with the same label links to it, and the place lists
/// the slides that do.
///
/// ```typst
/// The key assumption#anchor(<assumption>) is that the data are i.i.d.
/// #anchor(<setup>)[Experimental setup]
/// ```
#let anchor(
  /// A label such as `<assumption>`.
  target,
  /// Text shown at the place.
  ..body,
) = {
  assert(
    type(target) == label and body.named().len() == 0 and body.pos().len() <= 1,
    message: "unofficial-monash-touying: use #anchor(<name>) or #anchor(<name>)[Text].",
  )
  [#body.pos().join()#metadata("monash-anchor")#target#super(typographic: false, size: .7em, backlinks(target, size: 1em))]
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
  link(target, underline(offset: .15em, stroke: (paint: monash-blue, thickness: .6pt, dash: "dotted"), body))
  backref-marker(target)
}
