// A lecture: numbered examples and exercises, code, speaker notes, and a
// handout. Compile the handout with
//   typst compile examples/lecture.typ --input handout=true
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  aspect-ratio: "4-3",
  footer: [FIT1045 · Week 5],
  config-common(handout: sys.inputs.at("handout", default: "false") == "true"),
  config-info(
    title: [Recursion],
    subtitle: [Week 5 lecture],
    author: [Your Name],
    institution: [Faculty of Information Technology],
    date: datetime(year: 2026, month: 3, day: 30),
  ),
)

#show: show-monash-frames

#title-slide()

= Recursive Thinking

== Learning Outcomes

By the end of this lecture you can:

+ define a function in terms of itself,
+ identify the base case and the recursive case,
+ trace a recursive call by hand.

#speaker-note[Ask who has met recursion before.]

== Definition

#definition[Recursive Function][
  A function that calls itself on a smaller input, and stops at a base
  case.
]

#example[Factorial][
  $n! = n dot (n - 1)!$ for $n > 0$, and $0! = 1$.
]

== In Python

```python
def factorial(n):
    if n == 0:          # base case
        return 1
    return n * factorial(n - 1)
```

#pause

Each call waits for the one below it to return.

= Practice

== Tracing a Call

#example[Tracing `factorial(3)`][
  `factorial(3)` returns `3 * factorial(2)`, which returns `2 *
  factorial(1)`, and so on until `factorial(0)` returns `1`.
]

#warning[A missing base case recurses until the stack overflows.]

== Exercises

#exercise[Sum of a List][
  Write `total(xs)` that adds the numbers in `xs` recursively.
]

#exercise[Palindromes][
  Write `is_palindrome(s)` using recursion only.
]

#ending-slide(title: [Questions?])[
  Consultation: Tuesday 2--3 pm \
  Forum: the unit's discussion board
]
