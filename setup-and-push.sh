#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

GH="$HOME/bin/gh"

echo "Local commit:"
git log -1 --oneline

if [ ! -x "$GH" ]; then
  echo ""
  echo "GitHub CLI not found at $GH"
  echo "  export PATH=\"\$HOME/bin:\$PATH\""
  exit 1
fi

echo ""
echo "Checking GitHub login..."
"$GH" auth status || "$GH" auth login

echo ""
echo "Creating repo and pushing..."
"$GH" repo create hello-world-rya23 --public --source=. --remote=origin --push

echo ""
echo "Done! Your repo:"
"$GH" repo view --json url -q .url
