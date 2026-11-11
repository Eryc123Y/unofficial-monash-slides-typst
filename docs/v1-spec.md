# unofficial-monash-touying 1.0.0 — Specification

Status: approved scope, ready for implementation
Owner of requirements and acceptance: the reviewing session
Baseline: `main` at 0.1.3

## 1. Problem statement

`unofficial-monash-touying` is the only Monash-styled Typst slide package on
Typst Universe, but 0.1.x was shaped by one author's decks. Ordinary inputs
break it: a title longer than two lines overlaps the author block, a long slide
heading is silently clipped, a theorem with two paragraphs renders them on top
of each other, and several documented options do nothing. Its API also carries
names inherited from the Quarto template that do not read like Typst.

1.0.0 turns it into a general-purpose deck template that anyone at the
university can use for a research talk, a lecture, or a short presentation, and
whose public API can be frozen.

## 2. Goals

1. **No layout failure on ordinary input.** Every scenario in section 6 renders
   without overlap, clipping, or content outside the page.
2. **Every documented option has an effect**, and every public name is
   documented. Nothing undocumented is exported from the package entrypoint.
3. **A stable, Typst-idiomatic API.** Kebab-case parameter names, Typst-native
   value conventions, explicit export list. Breaking changes happen now, once.
4. **Covers three kinds of deck** (research talk, lecture, short talk) with the
   same small set of slide kinds and environments, shown by runnable examples.
5. **Regressions are caught mechanically**: one script and one CI workflow
   compile every deck in the repository and fail on any error or warning.

## 3. Non-goals

| Non-goal | Why |
|---|---|
| Bundling Monash logos, crests, or wordmarks | Trademark risk. Users pass their own through `logo:`. |
| A layout DSL or complex column helpers | Touying's `composer`, `cols`, and `side-by-side` already exist. |
| Showing and hiding exercise solutions | Out of scope; not wrapped, not documented. |
| QR codes, timelines, Gantt charts | Out of scope; not wrapped, not documented. Users pick their own packages. |
| Translated environment labels (Definition → 定义) | Needs an i18n mechanism unrelated to the rest; deferred to 1.1. |
| A `math-font` parameter | Users can set it with an ordinary show rule after the theme. |
| Dark mode | No demand yet. |
| Publishing to Typst Universe | Decided by the maintainer after trying the branch on a real deck. |

## 4. Users and stories

**Researcher (primary driver of detail)**

- As a researcher, I want the paper I am discussing cited on the slide where I
  discuss it, so the audience does not have to wait for the last slide.
- As an HDR student in a milestone review, I want backup slides that do not
  inflate the slide count, so "slide 12 of 30" stays honest.
- As a speaker with a 12-minute slot, I want to turn section divider slides
  off, so I do not spend five slides on navigation.
- As a mathematician, I want theorem-like environments with either per-kind or
  shared numbering, and I want multi-paragraph statements to look right.

**Lecturer or tutor**

- As a lecturer, I want numbered examples and exercises, code blocks, and a
  handout export, so one source serves the lecture and the notes.

**Anyone giving a presentation**

- As a first-time user, I want `typst init` to give me a deck I can edit
  straight away, and I want a mistake in the theme options to produce an error
  message that tells me what to write instead.
- As a speaker, I want one slide that shows a single statement large, and a
  closing slide with my contact details.

## 5. Requirements

Priorities: **P0** must ship in 1.0.0. **P1** should ship; may be dropped only
with a written reason in the final report. **P2** is recorded so the design
does not block it; do not build it.

### 5.1 Dependencies and manifest — P0

- **D1** `touying` 0.8.0, `frame-it` 2.1.0, `zebraw` 0.6.3. Before pinning,
  confirm each is the newest version listed on Typst Universe; if a newer one
  exists, use it and say so in the report. Never guess a version.
- **D2** `typst.toml`: `version = "1.0.0"`, `compiler = "0.15.0"`.
- **D3** Follow the Touying 0.8.0 "Theme Migration Guide" (in the package's
  `changelog.md`): style slide bodies through `setting:` instead of wrapping
  them, give special slides a hidden heading, and prefer
  `touying-fn-wrapper-raw` for helpers that need `self`.
- **D4** No deprecated Touying API is used (`semi-transparent-cover`,
  `touying-equation`, `utils.handout-only`).

### 5.2 Public API — P0

**A1. Theme parameters.** `monash-theme` accepts exactly these named
parameters, plus Touying `config-*` values as positional arguments:

| Parameter | Default | Values | Replaces |
|---|---|---|---|
| `aspect-ratio` | `"16-9"` | `"16-9"`, `"4-3"` | — |
| `font` | `"Arial"` | string or array of strings | hard-coded Arial |
| `code-font` | `"DejaVu Sans Mono"` | string or array of strings | hard-coded list |
| `font-size` | `22pt` | length | `fontsize` |
| `title-font-size` | `36pt` | length | `titlefontsize` |
| `title-color` | `black` | color | `titlecolor` |
| `title-graphic` | `auto` | `auto` (bundled background), `none`, or content | `titlegraphic` |
| `accent-color` | `monash-orange` | color | — |
| `logo` | `none` | `none` or content | `logo` (was ignored) |
| `outline` | `true` | bool | `toc` |
| `section-slides` | `true` | bool | — |
| `progress-bar` | `true` | bool | `progress-bar` (was ignored) |
| `slide-numbering` | `"1"` | `none` or a Typst numbering pattern that receives (current, total), e.g. `"1 / 1"` | — |
| `footer` | `none` | `none`, `auto`, or content | — |

- `footer: auto` shows the short title (falling back to the title) and the
  author, in the footer's left side.
- `accent-color` recolours everything that is orange today: list and
  enumeration markers, strong text, progress bar, outline numbers, the section
  number.

**A2. Removed and renamed names fail loudly.** Passing any of `fontsize`,
`titlefontsize`, `titlecolor`, `titlegraphic`, `toc`, `toc-args`,
`brand-motif`, `motto`, `progress-position` panics with a message that names
the replacement (or says the option was removed). Passing a string to
`title-graphic` panics and tells the user to pass `image("...")`, because a
path inside a package resolves against the package, not the user's project.

**A3. Slide functions.** Exported: `slide`, `title-slide`, `outline-slide`,
`new-section-slide`, `focus-slide`, `ending-slide`. Names follow the bundled
Touying themes.

- `outline-slide(title: auto, depth: 1)` can be called anywhere. With
  `outline: true`, `title-slide()` emits one automatically, as today.
- `focus-slide[...]`: full-bleed `monash-blue` background, large white centred
  text, no title bar, no footer, does not advance the slide counter.
- `ending-slide(title: [Thank you])[...]`: closing slide whose body is free
  content (contact details, links). No title bar; does not advance the counter.
- `section-slides: false` suppresses divider slides while sections still feed
  the outline and bookmarks.

**A4. Environments.** Exported: `definition`, `theorem`, `lemma`, `corollary`,
`proposition`, `assumption`, `example`, `exercise`, `remark`, `note`,
`warning`, `proof`.

- Call shapes for every framed environment: `#theorem[Body]` renders a body
  with no title; `#theorem[Title][Body]` renders both. A single argument is
  never treated as a title.
- Numbered: `definition`, `theorem`, `lemma`, `corollary`, `proposition`,
  `assumption`, `example`, `exercise`. Unnumbered: `remark`, `note`,
  `warning`.
- `show-monash-frames(numbering: true, shared-counter: false)`. With
  `shared-counter: true`, `definition`, `theorem`, `lemma`, `corollary`,
  `proposition`, and `assumption` share one counter; `example` and `exercise`
  keep their own.
- `proof`: `#proof[Body]` and `#proof[Title][Body]` both work. The end mark is
  right-aligned on the last line.
- A labelled environment can be referenced: `#theorem[..][..] <t>` then `@t`
  renders "Theorem 1" and links to it.

**A5. Explicit exports.** `lib.typ` exports by name only: the functions in A3
and A4, `monash-theme`, `show-monash-frames`, `monash-frame-style`,
`monash-accent-rule`, the colour tokens (`monash-*` colours), and a documented
list of Touying authoring names (`pause`, `uncover`, `only`, `alternatives`,
`meanwhile`, `item-by-item`, `alert`, `speaker-note`, `appendix`,
`handout-only`, `cols`, `side-by-side`, `empty-slide`, every `config-*`,
`components`, `utils`, and any others needed by the examples). Spacing and
size constants and underscore-prefixed helpers are not exported. A test file
asserts that every documented name resolves.

### 5.3 Robustness — P0

- **R1 Title slide.** Title, subtitle, author, institution, date, and `extra`
  flow in one column; nothing is positioned with absolute offsets that can
  collide. With `title-graphic: none` the text column may use the full width.
- **R2 Title bar.** A heading that does not fit on one line stays fully
  visible: it first shrinks (floor: 75% of the normal size), then wraps to two
  lines with the bar growing and the body starting below it. Never clipped.
- **R3 Frames.** Paragraphs, lists, display equations, and code blocks inside a
  framed environment have normal vertical spacing. No negative-space hacks.
- **R4 Footnotes.** Footnotes sit fully above the footer rule and progress bar.
- **R5 `progress-bar: false`** removes the progress bar.
- **R6 `logo`.** When set, the logo appears on the title slide and at the right
  end of the title bar on content slides, bounded in height. When `none`, the
  layout is identical to having no logo support.
- **R7 Appendix.** After `#show: appendix`: appendix sections are absent from
  the main outline and from other sections' divider outlines, the total in
  `slide-numbering` counts main slides only, and the progress bar is full on
  the last main slide.
- **R8 Fonts.** With defaults on macOS the decks compile with zero warnings.
  `code-font` defaults to a font embedded in the Typst compiler. The README
  states that a missing body font produces one warning and shows the one-line
  fix (`font: ...`).
- **R9 Overflow.** Touying's overflow detection stays enabled at its default;
  the theme does nothing that defeats it.
- **R10 Numbered lists** keep working to three nested levels (0.1.3 fix).
- **R11 Dead code.** No stored-but-unused options or unused constants remain.

### 5.4 Citations — P0

- **C1** `#bibliography(...)` on a slide renders in a compact size without a
  duplicate heading, and continues onto further slides when long.
- **C2** `config-common(show-bibliography-as-footnote: true)` (Touying's
  built-in mechanism) renders correctly with this theme. No new citation
  function is added.
- **C3** Both are demonstrated in the research example with a small `.bib`.

### 5.5 Visual polish — P0 unless marked

- **V1 Tables**: header row distinguished, horizontal hairlines only, comfortable
  cell padding. Implemented with set rules so a user's own `table` arguments
  still win.
- **V2 Figure captions**: smaller than body text, muted colour.
- **V3 Links**: visibly distinct from body text; outline entries are unaffected.
- **V4 Code**: inline code about 0.85em of the surrounding text, block code
  about 0.8em of body size.
- **V5 List markers**: levels 1–3 are distinct and clearly visible; deeper
  levels cycle.
- **V6 Section divider**: the number and a multi-line title stay visually
  aligned.
- **V7 Slide number**: at least 0.6em and dark enough to read on a projector
  (contrast ratio of 4.5:1 or better against white).
- **V8 Plain cover**: `title-graphic: none` gives a designed cover drawn with
  Typst shapes only (no raster asset), not merely a blank page with text.
- **V9 (P1) Speaker notes**: register a `notes-fn` built on `touying-notes` in
  theme colours.

### 5.6 Template, examples, documentation — P0

- **E1** `template/main.typ` is a neutral, editable skeleton: title, outline,
  two or three sections, one of each common element, an ending slide. It must
  compile immediately after `typst init`.
- **E2** `examples/` holds four decks: `showcase` (the feature tour, replacing
  `example/`), `research-talk`, `lecture`, `short-talk` (`outline: false`,
  `section-slides: false`). Update `exclude` in `typst.toml` accordingly.
- **E3** `README.md` is a user manual: quick start, options table matching A1,
  slide kinds, environments, fonts (including a CJK font example), logo policy,
  citations, handout mode and speaker notes (one paragraph each, pointing at
  Touying), and a "Migrating from 0.1.x" section.
- **E4** `CHANGELOG.md` covering 0.1.3 and 1.0.0, with breaking changes listed.
- **E5** `docs/reference.typ` compiles; every public function has a `tidy` doc
  comment. Preview images in `docs/preview/` and `thumbnail.png` are
  regenerated from the new title slide using a fixed date.

### 5.7 Engineering — P0

- **Q1** `tests/` contains at least: a stress deck covering section 6, an API
  test asserting the exports in A5, and a test that each name in A2 panics.
- **Q2** `scripts/check.sh` compiles the template, all examples, all tests, and
  the reference through a temporary local package path, and exits non-zero on
  any error or warning. It regenerates the thumbnail only with `--thumbnail`.
- **Q3** `.github/workflows/check.yml` runs the script on Typst 0.15.x. If a
  font is installed for CI, the workflow does it explicitly and the test decks
  select it; the published defaults are not changed for CI's sake.
- **Q4** Source files stay under 400 lines; split `src/theme.typ` by concern.
  Functions stay short and single-purpose.

### 5.8 Future considerations — P2

Translated environment labels, extra cover variants, a `math-font` option.
Keep label strings in one place so translation can be added later without an
API change.

## 6. Acceptance scenarios

Each scenario is checked on a rendered page, in both `16-9` and `4-3` where a
layout is involved.

1. **Long cover**: four-line title, two-line subtitle, three authors, a long
   institution, a date → no overlap, nothing outside the page, no text over the
   title graphic.
2. **Long heading**: a slide heading of about 90 characters → fully visible,
   body starts below the bar.
3. **Rich frame**: a theorem with two paragraphs, a bullet list, a display
   equation, and a trailing sentence → normal spacing throughout.
4. **Call shapes**: `#theorem[Body]`, `#theorem[Title][Body]`, `#proof[Body]`,
   `#proof[Title][Body]` → as specified in A4.
5. **Counters**: default gives Theorem 1, Lemma 1; `shared-counter: true` gives
   Theorem 1, Lemma 2; `numbering: false` shows no numbers.
6. **Footnote**: a slide with a footnote → text fully above the footer.
7. **Options take effect**: `progress-bar: false`, a `logo`, `footer: auto`,
   `slide-numbering: "1 / 1"`, `slide-numbering: none`, `accent-color: teal`,
   `section-slides: false`, `outline: false` each visibly change the output.
8. **Appendix**: two main sections then an appendix with two slides → R7 holds.
9. **Legacy names**: each name in A2 → the documented panic message.
10. **Table and figure**: a three-column table and a captioned figure → V1, V2.
11. **Citations**: C1 and C2 on real `.bib` data.
12. **CJK**: a slide with Chinese text and a CJK font appended to `font` →
    renders with that font, no layout change elsewhere.
13. **Handout**: `config-common(handout: true)` compiles and collapses
    animations.
14. **Clean build**: `scripts/check.sh` exits 0 with no warnings on macOS.

## 7. Success measures

- All 14 scenarios pass on review; all P0 requirements are met.
- The maintainer builds one real deck on this branch without any workaround in
  the deck's own source.
- After release: no bug-fix release is needed for a layout failure in the first
  30 days.

## 8. Open questions

| Question | Who | Blocking |
|---|---|---|
| Is Arial available on typst.app? If not, the README's font note needs a typst.app-specific line. | Maintainer, during trial | No |
| Does anything in the trial deck need an API change? | Maintainer | Blocks Universe submission only |
| Can `frame-it` 2.1.0 express the shared counter in A4 without forking its logic? If not, report the options before choosing one. | Implementer | No |

## 9. Phasing

One branch, committed in this order so each phase is reviewable:

1. Dependencies, API rename, explicit exports, legacy-name panics (D, A1, A2, A5).
2. Robustness fixes with the stress deck written first (R, Q1).
3. New slide kinds, environments, citations, footer (A3, A4, C).
4. Visual polish (V).
5. Template, examples, README, changelog, reference, CI (E, Q2–Q4).

Then: review against section 6 → maintainer trial on a real deck → Universe
submission when the maintainer says so.

## 10. Implementation rules

- Work only on the branch you are given. Commit locally with conventional
  commit messages (`feat:`, `fix:`, `docs:`, `test:`, `chore:`), no attribution
  lines, no emoji. Do not push, tag, open a pull request, or touch the
  `typst/packages` checkout.
- Write the failing test deck for a defect before fixing it, and look at the
  rendered PNG after: a clean compile does not prove a correct layout.
- Do not add raster assets. Do not add dependencies beyond D1 without asking.
- If a requirement conflicts with how Touying or frame-it behaves, stop and
  report the conflict with options instead of working around it silently.
- Finish with a report: one row per requirement ID (met / not met / deviated,
  with the page image that shows it), every deviation explained, and anything
  you noticed that this document missed.
