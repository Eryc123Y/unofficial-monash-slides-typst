// Institution and date on the cover: on one line with a separator when
// they fit, otherwise the date on its own line with no separator.
//   --input aspect=4-3   narrow format
//   --input logo=on      with a placeholder logo in the corner
//   --input font=Arial   in Arial, where the second cover needs two lines
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  aspect-ratio: sys.inputs.at("aspect", default: "16-9"),
  font: sys.inputs.at("font", default: auto),
  outline: false,
  logo: if sys.inputs.at("logo", default: "off") == "on" {
    image("assets/placeholder-wordmark.svg")
  },
  config-info(
    title: [Institution and Date],
    author: [Your Name],
    institution: [Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

// Fits on one line: "Monash University | 2026-03-14".
#title-slide()

// Does not fit: the date moves to its own line.
#title-slide(institution: [Faculty of Information Technology, Monash University])

// Institution alone wraps: the date still gets its own line.
#title-slide(institution: [Department of Data Science and Artificial Intelligence, Faculty of Information Technology, Monash University])

// No date: the institution alone, no separator.
#title-slide(institution: [Faculty of Information Technology, Monash University], date: none)
