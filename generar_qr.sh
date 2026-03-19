#!/usr/bin/env bash
set -euo pipefail

BASE="https://piter-cantropus.github.io/cajones-app"
OUT_DIR="out"
QR_DIR="$OUT_DIR/qr"
PDF="$OUT_DIR/qrs.pdf"

mkdir -p "$QR_DIR"

echo "Generando QR..."

jq -r '.[].nombre' data.json | while IFS= read -r name; do
  id=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
  url="$BASE/#$id"

  qrencode -o "$QR_DIR/$id.png" "$url"
done

echo "Armando grilla..."

# 3 cm a 300 DPI ≈ 354 px
SIZE=354

montage "$QR_DIR"/*.png \
  -tile 6x9 \
  -geometry ${SIZE}x${SIZE}+20+20 \
  -density 300 \
  "$PDF"

echo "Listo: $PDF"
