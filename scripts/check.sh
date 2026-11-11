#!/usr/bin/env bash
# Compiles every deck in the repository through a temporary local package
# path and fails on any error or warning.
#
# Usage: scripts/check.sh [--ignore-system-fonts] [--thumbnail]
#   --ignore-system-fonts  compile with only the fonts embedded in Typst
#   --thumbnail            also regenerate thumbnail.png and docs/preview/*.png
set -euo pipefail

cd "$(dirname "$0")/.."

font_flags=()
thumbnail=false
for arg in "$@"; do
  case "$arg" in
    --ignore-system-fonts) font_flags+=(--ignore-system-fonts) ;;
    --thumbnail) thumbnail=true ;;
    *) echo "unknown argument: $arg" >&2; exit 2 ;;
  esac
done

package_path="$(mktemp -d)"
trap 'rm -rf "$package_path"' EXIT
package_version="$(sed -n 's/^version = "\(.*\)"/\1/p' typst.toml)"
mkdir -p "$package_path/preview/unofficial-monash-touying"
ln -s "$PWD" "$package_path/preview/unofficial-monash-touying/$package_version"
export TYPST_PACKAGE_PATH="$package_path"

mkdir -p build
failures=0

# typst_compile <input> <output> [extra typst args...]
typst_compile() {
  local input="$1" output="$2"
  shift 2
  local log
  if ! log="$(typst compile --root . ${font_flags[@]+"${font_flags[@]}"} "$@" "$input" "$output" 2>&1)"; then
    echo "FAIL  $input"
    echo "$log" | sed 's/^/      /'
    failures=$((failures + 1))
  elif grep -q "warning" <<<"$log"; then
    echo "WARN  $input"
    echo "$log" | sed 's/^/      /'
    failures=$((failures + 1))
  else
    echo "ok    $input"
  fi
}

output_name() {
  echo "build/$(echo "${1%.typ}" | tr '/' '-').pdf"
}

decks=(template/main.typ)
for file in examples/*.typ tests/*.typ; do
  [[ -e "$file" ]] || continue
  [[ "$file" == tests/legacy.typ ]] && continue
  decks+=("$file")
done
decks+=(docs/reference.typ docs/preview.typ)

for deck in "${decks[@]}"; do
  typst_compile "$deck" "$(output_name "$deck")"
done

# Parametrised test decks: each extra input set is compiled separately.
variant_runs=(
  "tests/stress.typ|aspect=4-3"
  "tests/options.typ|aspect=4-3"
  "tests/environments.typ|counter=shared"
  "tests/environments.typ|counter=off"
  "tests/slide-kinds.typ|sections=off"
  "tests/slide-kinds.typ|aspect=4-3"
  "tests/citations.typ|footnotes=off"
  "tests/visual.typ|notes=on"
  "tests/visual.typ|aspect=4-3"
  "examples/lecture.typ|handout=true"
)
for variant in no-progress-bar logo footer-auto numbering-total numbering-none \
  accent-teal no-section-slides no-outline plain-cover; do
  variant_runs+=("tests/options.typ|variant=$variant")
done
variant_runs+=("tests/options.typ|variant=plain-cover,aspect=4-3")
variant_runs+=("tests/options.typ|variant=logo,aspect=4-3")
for run in "${variant_runs[@]}"; do
  deck="${run%%|*}"
  inputs="${run#*|}"
  input_args=()
  IFS=',' read -ra pairs <<<"$inputs"
  for pair in "${pairs[@]}"; do input_args+=(--input "$pair"); done
  echo -n "[$inputs] "
  typst_compile "$deck" "build/$(basename "${deck%.typ}")-${inputs//[=,]/-}.pdf" "${input_args[@]}"
done

# Decks that name an installed font run only where that font exists. A deck
# lists its fonts in `// requires-font: <family>` lines.
installed_fonts="$(typst fonts ${font_flags[@]+"${font_flags[@]}"})"
font_available() {
  grep -Fqx "$1" <<<"$installed_fonts"
}
font_runs=()
for deck in tests/fonts/*.typ; do
  [[ -e "$deck" ]] || continue
  font_runs+=("$deck||$(sed -n 's/^\/\/ requires-font: //p' "$deck" | head -1)")
done
font_runs+=("tests/fonts/cjk.typ|cjk=off|Noto Sans CJK SC")
font_runs+=("tests/fonts/cjk.typ|latin=Arial|Arial")
font_runs+=("tests/fonts/arial.typ|aspect=4-3|Arial")
font_runs+=("examples/showcase.typ|font=Arial|Arial")
for run in "${font_runs[@]}"; do
  IFS='|' read -r deck inputs font <<<"$run"
  if ! font_available "$font"; then
    echo "skip  $deck [$inputs] (font \"$font\" not installed)"
    continue
  fi
  input_args=()
  if [[ -n "$inputs" ]]; then
    IFS=',' read -ra pairs <<<"$inputs"
    for pair in "${pairs[@]}"; do input_args+=(--input "$pair"); done
  fi
  echo -n "[$inputs] "
  typst_compile "$deck" "build/fonts-$(basename "${deck%.typ}")-${inputs//[=,]/-}.pdf" ${input_args[@]+"${input_args[@]}"}
done

# Handout mode collapses animations: fewer pages than the presentation.
count_pages() {
  local dir
  dir="$(mktemp -d)"
  typst compile --root . ${font_flags[@]+"${font_flags[@]}"} --ppi 10 "$@" "$dir/p-{p}.png" >/dev/null 2>&1
  ls "$dir" | wc -l | tr -d ' '
  rm -rf "$dir"
}
presentation_pages="$(count_pages tests/handout.typ)"
handout_pages="$(count_pages --input handout=true tests/handout.typ)"
if [[ "$presentation_pages" == 7 && "$handout_pages" == 4 ]]; then
  echo "ok    handout collapses 7 pages to 4"
else
  echo "FAIL  handout: expected 7 and 4 pages, got $presentation_pages and $handout_pages"
  failures=$((failures + 1))
fi

# Every 0.1.x option name must fail with a message naming the replacement.
legacy_cases=(
  "fontsize|renamed to \`font-size\`"
  "titlefontsize|renamed to \`title-font-size\`"
  "titlecolor|renamed to \`title-color\`"
  "titlegraphic|renamed to \`title-graphic\`"
  "toc|renamed to \`outline\`"
  "toc-args|\`toc-args\` was removed"
  "brand-motif|\`brand-motif\` was removed"
  "motto|\`motto\` was removed"
  "progress-position|\`progress-position\` was removed"
  "title-graphic-path|Pass \`title-graphic: image("
)
for case in "${legacy_cases[@]}"; do
  name="${case%%|*}"
  expected="${case#*|}"
  if log="$(typst compile --root . ${font_flags[@]+"${font_flags[@]}"} --input "legacy=$name" tests/legacy.typ build/legacy.pdf 2>&1)"; then
    echo "FAIL  legacy option $name compiled without an error"
    failures=$((failures + 1))
  elif grep -qF "$expected" <<<"$log"; then
    echo "ok    legacy option $name"
  else
    echo "FAIL  legacy option $name: message does not mention: $expected"
    echo "$log" | sed 's/^/      /'
    failures=$((failures + 1))
  fi
done

if [[ "$thumbnail" == true ]]; then
  preview_dir="$(mktemp -d)"
  typst compile --root . --ignore-system-fonts --ppi 100 docs/preview.typ "$preview_dir/p-{p}.png"
  cp "$preview_dir/p-1.png" thumbnail.png
  cp "$preview_dir/p-1.png" docs/preview/title-slide.png
  cp "$preview_dir/p-3.png" docs/preview/content-slide.png
  cp "$preview_dir/p-4.png" docs/preview/academic-frames.png
  rm -rf "$preview_dir"
  echo "Regenerated thumbnail.png and docs/preview/*.png"
fi

if [[ "$failures" -gt 0 ]]; then
  echo "$failures check(s) failed"
  exit 1
fi
echo "All checks passed"
