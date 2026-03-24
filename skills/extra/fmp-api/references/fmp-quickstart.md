# Financial Modeling Prep（FMP）API クイックリファレンス

Base URL（stable）: `https://financialmodelingprep.com/stable`

## 認証

環境変数 `FMP_API_KEY` を設定。クエリ `apikey=` またはヘッダ `apikey:` で渡す。

## よく使うエンドポイント（例）

| 用途 | パス |
|------|------|
| リアルタイム気配 | `/quote` |
| 損益計算書 | `/income-statement` |
| 貸借対照表 | `/balance-sheet-statement` |
| キャッシュフロー | `/cash-flow-statement` |
| 主要指標 | `/key-metrics` |

レート制限・プラン別の利用可否は公式ドキュメントを参照: https://site.financialmodelingprep.com/developer/docs
