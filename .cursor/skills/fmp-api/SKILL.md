---
name: fmp-api
description: Financial Modeling Prep（FMP）API を用いて株価・財務データを取得する。米国株のクォート、財務諸表、指標が必要で FMP を使う方針のときに使用。環境変数 FMP_API_KEY が必要。
---

# FMP API

## 前提

- `FMP_API_KEY` を `.env` または環境に設定する
- 無料枠には遅延・レート制限がある。大量取得やリアルタイム要件は公式プランを確認

## 基本方針

1. 銘柄シンボルを確定する（米国株はティッカー）
2. `/quote` で最新気配を取得
3. 決算分析には損益・貸借・CF 各ステートメントを期間指定で取得

## Python 例（要点）

```python
import os, requests

BASE = "https://financialmodelingprep.com/stable"
KEY = os.environ["FMP_API_KEY"]

def get_quote(symbol: str):
    r = requests.get(f"{BASE}/quote", params={"symbol": symbol, "apikey": KEY})
    r.raise_for_status()
    data = r.json()
    return data[0] if data else {}
```

## 詳細

エンドポイント一覧と注意事項は [references/fmp-quickstart.md](references/fmp-quickstart.md) を参照。
