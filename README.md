# skills-audience-segment-designer-v2

ウェブ広告向けの**オーディエンスセグメント設計** Skill と、Cursor / Claude 用の補助スキルをまとめたリポジトリです。ファイルは役割ごとにフォルダへ分割してあります。

---

## フォルダ構成と役割

| パス | 役割 |
|------|------|
| **`library/reference-md/audience-segment-designer/`** | オーディエンス設計スキルが参照する**ドメイン知識の正規ソース**（ビジネスモデル型マップ、5seg ロジック、媒体別設定観点、クライアント向けブリーフ要素など）。編集・差し替えは基本ここだけ行えばよい。 |
| **`skills/audience-segment-designer/`** | **メイン Skill の実体**。Claude.ai ではこのフォルダを ZIP にしてアップロードする（下記）。`SKILL.md` に概要・入力・フロー・禁止事項があり、手順の詳細は `references/` 内の分割ファイルに記載。Cursor / Claude Code もここを参照。 |
| **`skill-package/`** | （任意）`skills/audience-segment-designer/` へのシンボリックリンク。旧手順・ショートカット用。 |
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
├── audience-segment-designer/        ← メイン Skill（Claude.ai へはこのフォルダを ZIP でアップロード）
│   ├── SKILL.md
│   └── references/
│       ├── workflow-step1-through-2-5.md
│       ├── step3-executive-brief.md
│       ├── step4-ad-delivery-excel.md
│       └── *.md → library/...       （シンボリックリンク）
└── extra/                            ← 補助スキル一式
    └── …

skill-package/  → audience-segment-designer へのシンボリックリンク（任意）

scripts/build-claude-skill-zip.sh   ← 参照ファイルのリンクを実体に解決して ZIP 化したいとき（任意）

.cursor/skills/   → 上記 skills へのシンボリックリンク群
.claude/skills/   → Claude Code 用（メインスキルへのリンク）
```

---

## Claude（Agent Skills）への取り込み方

Anthropic の Agent Skills は、**フォルダ 1 つ = スキル 1 つ**で、その直下に必ず `SKILL.md` があります。公式: [Agent Skills（Claude Docs）](https://code.claude.com/docs/en/skills)

### 取り込み先の違い

| 利用環境 | 操作の要点 | 向いている用途 |
|----------|------------|----------------|
| **Claude.ai**（Web） | **`audience-segment-designer` フォルダを ZIP にしてアップロード** | チャット上でスキルを効かせたいとき |
| **Claude Code** | `~/.claude/skills/` または **プロジェクト**の `.claude/skills/` にスキルフォルダを置く | リポジトリを開いて実行するとき |

### A. Claude.ai（シンプルな手順）

1. リポジトリ内の **`skills/audience-segment-designer/`** を ZIP ファイルにする（圧縮後のトップに **`audience-segment-designer/SKILL.md`** がある形）。  
2. Claude の **Settings → Features → Skills**（名称は製品版で変わる場合あり）から、その ZIP をアップロードする。  
3. 依頼文は `SKILL.md` の description に近い表現にすると発動しやすいです。

**補足:** `references/` 内の一部ファイルがシンボリックリンクのため、環境によっては ZIP に実体が入らないことがあります。アップロード後にスキルが正しく動かない場合は、リンクを実ファイルに解決した ZIP を `./scripts/build-claude-skill-zip.sh` で生成する（既定で `dist/audience-segment-designer.zip`）、または手動で `references/` をコピーしてから ZIP してください。macOS で ZIP を展開するときにエラーになる場合は、ターミナルから `unzip` で展開する方法も試してください。

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
2. **Claude.ai** の場合は **`audience-segment-designer` を ZIP にしてアップロード**済みにする。**Cursor / Claude Code** の場合はスキルを有効にする（上記「取り込み方」）。  
3. セグメント設計の依頼をする。  
4. ①② をレビューし、必要なら `library/reference-md/` の媒体別ガイドと突き合わせる。

---

## ライセンス・免責

利用条件は必要に応じて整備してください。`skills/extra/` の投資関連スキルは分析・整理用テンプレートであり、投資勧誘ではありません。
