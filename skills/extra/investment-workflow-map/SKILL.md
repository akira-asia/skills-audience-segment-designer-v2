---
name: investment-workflow-map
description: 投資関連スキルを日次・決算シーズン・月次でどう連携するかのマップ。投資ワークフロー全体を説明したいとき、または「どのスキルを順に使う？」と聞かれたときに使用。
---

# Investment Workflow Map

## 日次

1. `news-filter` — 重要ニュースを Tier 化
2. Tier 1 があれば `source-verification` で一次ソース確認
3. 夜: `investment-journal` で判断と心理を記録

## 決算シーズン

1. `earnings-analysis` — 構造化分析
2. `source-verification` — Fact / Guidance / Speculation の分離
3. `stock-valuation-checker` — 評価の更新
4. `investment-thesis-writer` — テーゼの更新が必要なとき
5. `analysis-writer` — 必要なら外向けの記事にまとめる

## 月次

1. `portfolio-review` — バランスとテーゼ
2. `stop-loss-decision` — 個別の売却検討が必要なとき
3. `investment-learning` — 学びをスキルに反映する案

## スキル連鎖の例

- `earnings-analysis` → `source-verification` → `stock-valuation-checker` →（必要なら）`investment-thesis-writer` → `analysis-writer`
- `portfolio-review` → `stop-loss-decision`
- `investment-journal` → `investment-learning`

データ取得は `fmp-api` や Web 検索ポリシーに従う。
