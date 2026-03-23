#!/usr/bin/env bash
# Claude.ai 用: シンボリックリンクを実ファイルに解決した skill-package を ZIP する
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-${ROOT}/dist/skill-package-for-claude.zip}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
mkdir -p "$(dirname "$OUT")"
PKG="${STAGE}/skill-package"
mkdir -p "${PKG}/references"
cp "${ROOT}/skills/audience-segment-designer/SKILL.md" "${PKG}/"
cp -L "${ROOT}/skills/audience-segment-designer/references/"*.md "${PKG}/references/"
( cd "${STAGE}" && zip -r -q "$OUT" skill-package )
echo "Wrote: $OUT"
