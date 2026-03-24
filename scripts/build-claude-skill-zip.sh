#!/usr/bin/env bash
# Claude.ai 用: シンボリックリンクを実ファイルに解決した audience-segment-designer を ZIP する
#
# - ZIP ルートは audience-segment-designer/（SKILL.md は audience-segment-designer/SKILL.md）
# - zip -r -X: 拡張属性を除外し、Finder・他 OS・Claude 双方の互換性を上げる
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-${ROOT}/dist/audience-segment-designer.zip}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
mkdir -p "$(dirname "$OUT")"
PKG="${STAGE}/audience-segment-designer"
mkdir -p "${PKG}/references"
cp "${ROOT}/skills/audience-segment-designer/SKILL.md" "${PKG}/"
cp -L "${ROOT}/skills/audience-segment-designer/references/"*.md "${PKG}/references/"

( cd "${STAGE}" && zip -r -X -q "$OUT" audience-segment-designer )
echo "Wrote: $OUT"
