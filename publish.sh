#!/bin/bash
set -euo pipefail

./update-slides.sh

git add .

if git diff --cached --quiet; then
  echo "Nessuna modifica da pubblicare."
  exit 0
fi

git commit -m "Update site content"
git push
