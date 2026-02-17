#!/bin/bash
set -euo pipefail

PHOTO_DIR="content/photos/slideshow"
OUTPUT_FILE="content/slides.json"

mkdir -p "$PHOTO_DIR"

tmp_list="$(mktemp)"
find "$PHOTO_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | LC_ALL=C sort > "$tmp_list"

{
  echo "["
  first=1
  while IFS= read -r file; do
    [ -z "$file" ] && continue
    escaped="$(printf '%s' "$file" | sed 's/\\/\\\\/g; s/\"/\\"/g')"
    if [ "$first" -eq 0 ]; then
      echo ","
    fi
    printf "  \"%s\"" "$escaped"
    first=0
  done < "$tmp_list"
  echo
  echo "]"
} > "$OUTPUT_FILE"

rm -f "$tmp_list"
echo "Slideshow aggiornato: $OUTPUT_FILE"
