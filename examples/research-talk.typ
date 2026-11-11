// A research talk: citations on the slide where they are made, a shared
// counter for statements, and backup slides that do not count.
#import "@preview/unofficial-monash-touying:1.0.0": *

#show: monash-theme.with(
  footer: auto,
  slide-numbering: "1 / 1",
  config-common(show-bibliography-as-footnote: true),
  config-info(
    title: [Residual Connections and the Depth of Neural Networks],
    short-title: [Residual Depth],
    subtitle: [Milestone review],
    author: [Your Name],
    institution: [Department of Data Science and AI, Monash University],
    date: datetime(year: 2026, month: 3, day: 14),
  ),
)

#show: show-monash-frames.with(shared-counter: true)

#title-slide()

= Background

== Why Depth Matters

- Deep networks learn hierarchical features @lecun2015deep.
- Very deep plain networks are hard to train; residual connections fix
  this @he2016resnet.
- Attention models stack dozens of residual blocks @vaswani2017attention.

== Setting

#definition[Residual Block][
  A block computes $y = x + F(x)$, where $F$ is a small network.
] <def-block>

#assumption[Lipschitz Layers][
  Each $F$ is $L$-Lipschitz with $L < 1$.
] <asm-lipschitz>

= Contribution

== Main Result

#theorem[Stable Depth][
  Under @asm-lipschitz, a stack of $n$ blocks as in @def-block is
  invertible for every $n$.
] <thm-stable>

#proof[
  Each block is a contraction plus the identity, hence invertible, and a
  composition of invertible maps is invertible.
]

== Consequences

#corollary[
  Training with @thm-stable's constraint never collapses two inputs.
]

#proposition[
  The constraint costs at most a constant factor in expressiveness.
]

== References

#bibliography("refs.bib", style: "ieee")

#show: appendix

= Backup

== Ablation Details

#table(
  columns: 3,
  table.header[Depth][Plain][Residual],
  [18], [72.1%], [73.4%],
  [34], [71.5%], [75.2%],
  [50], [68.9%], [76.0%],
)

== Proof Details

#lemma[
  The inverse of $x |-> x + F(x)$ is the fixed point of $z |-> y - F(z)$.
]
