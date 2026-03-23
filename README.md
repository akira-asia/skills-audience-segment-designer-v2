# skills-audience-segment-designer-v2

ウェブ広告向けの**オーディエンスセグメント設計** Skill と、Cursor / Claude 用の補助スキルをまとめたリポジトリです。ファイルは役割ごとにフォルダへ分割してあります。

---

## フォルダ構成と役割

| パス | 役割 |
|------|------|
| **`library/reference-md/audience-segment-designer/`** | オーディエンス設計スキルが参照する**ドメイン知識の正規ソース**（ビジネスモデル型マップ、5seg ロジック、媒体別設定観点、クライアント向けブリーフ要素など）。編集・差し替えは基本ここだけ行えばよい。 |
| **`skills/audience-segment-designer/`** | **メインの Agent Skill パッケージ**（Claude の ZIP 単位・Cursor の参照元）。`SKILL.md` に概要・入力・フロー・禁止事項があり、手順の詳細は `references/` 内の分割ファイルに記載。 |
| **`skills/audience-segment-designer/references/`** | 実行手順（STEP1〜4）の分割ドキュメントと、上記 `library/` への**シンボリックリンク**。スキル実行時はここ経由で参照する。 |
| **`skills/extra/`** | オーディエンス設計以外の**汎用・投資ワークフロー用**などの補助スキル（`code-review`、`learn`、各投資テンプレート等）。必要なものだけ Claude / 別プロジェクトにコピー可能。 |
| **`.cursor/skills/`** | Cursor が読み込むスキル置き場。**各エントリは `skills/` へのシンボリックリンク**（メインは `audience-segment-designer`、その他は `skills/extra/*`）。 |
| **`.claude/skills/`** | Claude Code がプロジェクト単位で読むスキル置き場。`audience-segment-designer` は `skills/audience-segment-designer` へのリンク。 |
| **ルート `README.md`** | 本ドキュメント（リポジトリの地図と利用手順）。 |
| **ルート `SKILL.md` / `references/`** | `skills/audience-segment-designer/` への**シンボリックリンク**。エディタや旧手順からルートだけ触りたい場合のエイリアス。 |

### ディレクトリツリー（要点）

```text
library/
└── reference-md/
    └── audience-segment-designer/    ← 参照用 .md の実体（正規ソース）
        ├── bm-segment-axis-map.md
        ├── 5seg-segment-logic.md
        ├── client-summary-template.md
        ├── google-ads-audience-settings.md
        └── meta-ads-audience-settings.md

skills/
├── audience-segment-designer/        ← メイン Skill（ZIP もこれ）
│   ├── SKILL.md                      ← 概要・入力・フロー・索引
│   └── references/
│       ├── workflow-step1-through-2-5.md
│       ├── step3-executive-brief.md
│       ├── step4-ad-delivery-excel.md
│       └── *.md → library/...       （シンボリックリンク）
└── extra/                            ← 補助スキル一式
    ├── code-review/
    ├── learn/
    └── …

.cursor/skills/   → 上記 skills へのシンボリックリンク群
.claude/skills/   → Claude Code 用（メインスキルへのリンク）
```

---

## Claude（Agent Skills）への取り込み方

Anthropic の Agent Skills は、**フォルダ 1 つ = スキル 1 つ**で、その直下に必ず `SKILL.md` があります。オーディエンス設計の単位は **`skills/audience-segment-designer/`** です。

### 取り込み先の違い

| 利用環境 | スキルを置く場所 | 向いている用途 |
|----------|------------------|----------------|
| **Claude.ai**（Web） | Settings から ZIP をアップロード | チャットでスキルを効かせたいとき |
| **Claude Code** | `~/.claude/skills/` または **プロジェクト**の `.claude/skills/` | リポジトリを開いて実行するとき |

公式: [Agent Skills（Claude Docs）](https://code.claude.com/docs/en/skills)

### A. Claude.ai（ZIP）

1. **`skills/audience-segment-designer/`** フォルダごと ZIP にする（`SKILL.md` と `references/` 全体を含める）。  
2. Claude の **Settings → Features → Skills** からアップロード。  
3. 依頼文は `SKILL.md` の description に近い表現にすると発動しやすいです。

### B. Claude Code（このリポジトリをそのまま使う）

- **`.claude/skills/audience-segment-designer`** が `skills/audience-segment-designer` を指しています。プロジェクトルートで Claude Code を開けば読み込まれます。  
- グローバルに使う場合は `skills/audience-segment-designer/` を `~/.claude/skills/` にコピー、またはシンボリックリンクで追加。  
- **補助スキル**は `skills/extra/<スキル名>/` を同様にコピーまたはリンクしてください。

**Windows 等でシンボリックリンクが使えない場合**は、`skills/audience-segment-designer/` または `skills/extra/<名前>/` をそのままコピーして配置してください。

---

## この Skill が出力するもの（最終成果物は 2 点）

| # | 成果物 | 形式 |
|---|--------|------|
| ① | エグゼクティブ向けセグメントブリーフ | `.md` |
| ② | 広告配信設定 Excel | `.xlsx` |

命名例: `executive-segment-brief-[クライアント名]-[対象5seg].md` / `ad-delivery-settings-[クライアント名]-[対象5seg].xlsx`

内部フローと STEP 詳細は **`skills/audience-segment-designer/SKILL.md`** および同梱の `references/workflow-*.md` / `step3-*.md` / `step4-*.md` を参照してください。

---

## 入力について（必読）

**ビジネス分析**および **5seg 分析**の結果を Markdown で渡すと精度が上がります。5seg については、厳密な分析 md でなくても、**課題解決に紐づく提案資料**でセグメントと方針が読み取れれば可です。

手法の参照: [Method Library](https://method-library.kandoasia.com/)

分析 md がない場合は `SKILL.md` の入力テンプレートで進められます（【1】【2】【4】必須）。

---

## 使い方の目安

1. ビジネス分析 md・5seg 関連資料を用意する。  
2. Claude / Cursor でスキルを有効にする（上記「取り込み方」）。  
3. セグメント設計の依頼をする。  
4. ①② をレビューし、必要なら `library/reference-md/` の媒体別ガイドと突き合わせる。

---

## ライセンス・免責

利用条件は必要に応じて整備してください。`skills/extra/` の投資関連スキルは分析・整理用テンプレートであり、投資勧誘ではありません。
