#!/usr/bin/env bash
set -euo pipefail

mkdir -p build

typst compile --root . template/main.typ build/template-main.pdf
typst compile --root . examples/code-theorem-algorithm.typ build/code-theorem-algorithm.pdf
typst compile --root . --pages 1 template/main.typ thumbnail.png

echo "Compiled template/main.typ, examples/code-theorem-algorithm.typ, and thumbnail.png"
