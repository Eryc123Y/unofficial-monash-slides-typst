// requires-font: Noto Sans CJK SC
// Scenario 12: a CJK font appended to `font` renders Chinese text with that
// font and leaves Latin text unchanged. Pages 5 and 6 have no Chinese and
// render identically with `--input cjk=off`, which drops the CJK font.
#import "@preview/unofficial-monash-touying:1.0.0": *

#let latin = sys.inputs.at("latin", default: "Libertinus Serif")
#let cjk = sys.inputs.at("cjk", default: "on") == "on"

#show: monash-theme.with(
  font: if cjk { (latin, "Noto Sans CJK SC") } else { latin },
  outline: false,
  config-info(
    title: [Fonts],
    author: [Test Author],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames

#title-slide()

= 中文

== 中文内容

- 深度学习改变了计算机视觉。
- 中英混排：Typst 让排版更简单。

#theorem[定理][每个收缩映射都有唯一的不动点。]

= Latin

== Latin only

- No Chinese text on this slide.
- The layout matches the deck without the CJK font.

== Latin frame

#definition[Term][A frame without any Chinese text.]
