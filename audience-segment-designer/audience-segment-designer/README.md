# audience-segment-designer

ウェブ広告で狙うべき顧客セグメントの特定と優先度決定を行う Skill。  
**最終成果物は次の 2 ファイルに限定する：**

① エグゼクティブ向けセグメントブリーフ（`.md`）  
② 広告配信設定 Excel（`.xlsx`）

---

## ディレクトリ構成

```
audience-segment-designer/
├── README.md                          ← このファイル
├── SKILL.md                           ← Skill本体（必須）
└── references/
    ├── bm-segment-axis-map.md         ← BM型×推奨セグメント軸マッピング（STEP2-0で参照）
    ├── 5seg-segment-logic.md          ← 5seg別セグメント設計ロジック（STEP2-1で参照）
    ├── client-summary-template.md     ← ブリーフの記述要素の参考（STEP3で参照）
    ├── google-ads-audience-settings.md← Google広告オーディエンスリファレンス（STEP4で参照）
    └── meta-ads-audience-settings.md  ← Meta広告オーディエンスリファレンス（STEP4で参照）
```

---

## 配置場所

| 用途 | パス |
|------|------|
| ユーザー共通（全プロジェクトで使用） | `~/.cursor/skills/audience-segment-designer/` |
| プロジェクト固有 | `.cursor/skills/audience-segment-designer/` |

---

## 発動トリガー（主要例）

- 「広告のセグメント設計をしたい」
- 「誰に広告を出すべきか教えて」
- 「ターゲット設計して」
- 「離脱顧客向けにセグメント設計して」
- 「クライアントに提示できるセグメント資料を作りたい」
- ビジネスモデル分類 Excel（39 型）のアップロード時

---

## バージョン

- v4.1（2026-03-23）
- 主な変更：STEP3ブリーフの①〜⑥固定構成・ExcelのGoogle/Metaシート分離・CRMリスト定義シート独立追加
