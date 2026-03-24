#!/usr/bin/env bash
# Claude.ai 用: シンボリックリンクを実ファイルに解決した skill-package を ZIP する
#
# - ZIP ルートは必ず skill-package/（SKILL.md は skill-package/SKILL.md）
# - zip -r -X: 拡張属性を除外し、Finder・他 OS・Claude 双方の互換性を上げる
# - 手作り ZIP（シンボリックリンクのみ・ルートフォルダなし等）は展開エラー（例: macOS 512）の原因になりやすい
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-${ROOT}/dist/skill-package.zip}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
mkdir -p "$(dirname "$OUT")"
PKG="${STAGE}/skill-package"
mkdir -p "${PKG}/references"
cp "${ROOT}/skills/audience-segment-designer/SKILL.md" "${PKG}/"
cp -L "${ROOT}/skills/audience-segment-designer/references/"*.md "${PKG}/references/"

( cd "${STAGE}" && zip -r -X -q "$OUT" skill-package )
echo "Wrote: $OUT"
