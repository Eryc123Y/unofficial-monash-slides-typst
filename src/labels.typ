// Every user-visible label string of the theme, per language. The language
// follows `text.lang` (and `text.region` for Traditional Chinese), and
// `show-monash-frames(labels: ..)` overrides single labels.

#let _translations = (
  en: (
    definition: "Definition",
    theorem: "Theorem",
    lemma: "Lemma",
    corollary: "Corollary",
    proposition: "Proposition",
    assumption: "Assumption",
    example: "Example",
    exercise: "Exercise",
    remark: "Remark",
    note: "Note",
    warning: "Warning",
    proof: "Proof",
    thank-you: "Thank you",
    // Punctuation around a title: "Theorem 1: Title", "Proof (Title)."
    title-separator: ": ",
    proof-title-open: " (",
    proof-title-close: ")",
    proof-end: ". ",
  ),
  zh: (
    definition: "定义",
    theorem: "定理",
    lemma: "引理",
    corollary: "推论",
    proposition: "命题",
    assumption: "假设",
    example: "例",
    exercise: "练习",
    remark: "注记",
    note: "注",
    warning: "注意",
    proof: "证明",
    thank-you: "谢谢",
    title-separator: "：",
    proof-title-open: "（",
    proof-title-close: "）",
    proof-end: "：",
  ),
  zh-Hant: (
    definition: "定義",
    theorem: "定理",
    lemma: "引理",
    corollary: "推論",
    proposition: "命題",
    assumption: "假設",
    example: "例",
    exercise: "練習",
    remark: "註記",
    note: "註",
    warning: "注意",
    proof: "證明",
    thank-you: "謝謝",
    title-separator: "：",
    proof-title-open: "（",
    proof-title-close: "）",
    proof-end: "：",
  ),
)

/// Keys a user may override with `show-monash-frames(labels: ..)`.
#let label-keys = _translations.en.keys()

#let _language(lang, region) = if lang != "zh" { "en" } else if (
  region in ("TW", "HK", "MO")
) { "zh-Hant" } else { "zh" }

#let _marker(key) = label("monash-label-" + key)

/// The label for `key` in the language at the place of use. It carries a
/// marker so that `with-labels` can replace it.
#let label-text(key) = [#context _translations.at(_language(text.lang, text.region)).at(key)#_marker(key)]

/// Replaces the labels named in `overrides` throughout `body`.
#let with-labels(overrides, body) = overrides.pairs().fold(body, (acc, pair) => {
  show _marker(pair.first()): pair.last()
  acc
})
