#!/usr/bin/env bash
set -euo pipefail

mkdir -p build

typst compile --root . template/main.typ build/template-main.pdf
typst compile --root . examples/frame-environments.typ build/frame-environments.pdf
typst compile --root . --pages 1 template/main.typ thumbnail.png

echo "Compiled template/main.typ, examples/frame-environments.typ, and thumbnail.png"
