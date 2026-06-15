#!/bin/bash
# Rebuild the appcycle helper into the `bin` stow package.
# The resulting binary is committed to the repo and deployed via `stow bin`,
# so a fresh machine needs no compiler — run this only when the source changes.
#
# Note: ad-hoc code signing changes the binary's identity on every rebuild, so
# you must re-grant Accessibility permission to the binary afterwards
# (System Settings > Privacy & Security > Accessibility).
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SRC="$DOTFILES_DIR/tools/appcycle/appcycle.swift"
OUT="$DOTFILES_DIR/bin/.local/bin/appcycle"

mkdir -p "$(dirname "$OUT")"
swiftc -O "$SRC" -o "$OUT"
codesign --force --sign - "$OUT"
echo "Built $OUT"
