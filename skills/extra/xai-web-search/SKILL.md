---
name: xai-web-search
description: xAI（Grok）の検索系ツール方針で X 投稿や Web を調べる。X の投稿収集、最新ニュース調査、一次情報の当たりを付けるときに使用。API キーと SDK はユーザー環境に依存する。
---

# xAI Web Search

## 前提

- `XAI_API_KEY` を設定（`.env` 推奨）
- 実際の呼び出しは `xai-sdk-python` 等、ユーザーが入れた CLI を優先

## 使い分け

- **X**: 投稿・ナラティブの収集
- **Web**: ニュース・公式発表の補足

## 制約（一般的な注意）

- ハンドル・ドメインのフィルタには上限がある場合がある
- 日付範囲を絞らないと遅い場合がある

## 参照

[references/xai-env.md](references/xai-env.md)
