// Asserts that the package exports exactly the documented public names.
// Compiled by scripts/check.sh; a mismatch fails the compile.
#import "@preview/unofficial-monash-touying:1.0.0" as monash

#let documented = (
  // Theme and slide kinds
  "monash-theme",
  "slide",
  "title-slide",
  // Environments
  "show-monash-frames",
  "monash-frame-style",
  "definition",
  "theorem",
  "lemma",
  "corollary",
  "remark",
  "note",
  "warning",
  "proof",
  // Design tokens
  "monash-accent-rule",
  "monash-blue",
  "monash-blue-dark",
  "monash-blue-grey",
  "monash-blue-wash",
  "monash-charcoal",
  "monash-dark-grey",
  "monash-green",
  "monash-grey",
  "monash-grey-light",
  "monash-grey-soft",
  "monash-muted",
  "monash-orange",
  "monash-orange-soft",
  "monash-paper",
  "monash-slate",
  "monash-teal",
  // Touying authoring names
  "alert",
  "alternatives",
  "appendix",
  "cols",
  "components",
  "config-colors",
  "config-common",
  "config-info",
  "config-methods",
  "config-page",
  "config-store",
  "effect",
  "empty-slide",
  "handout-only",
  "item-by-item",
  "jump",
  "meanwhile",
  "only",
  "pause",
  "side-by-side",
  "speaker-note",
  "touying-recall",
  "uncover",
  "utils",
  "waypoint",
)

#let exported = dictionary(monash).keys()
#let missing = documented.filter(name => name not in exported)
#let extra = exported.filter(name => name not in documented)

#assert(missing == (), message: "documented but not exported: " + repr(missing))
#assert(extra == (), message: "exported but not documented: " + repr(extra))
#for name in documented.filter(it => it.starts-with("monash-") and it not in ("monash-theme", "monash-frame-style", "monash-accent-rule")) {
  assert(type(dictionary(monash).at(name)) == color, message: name + " is not a color")
}

All #documented.len() documented names are exported, and nothing else.
