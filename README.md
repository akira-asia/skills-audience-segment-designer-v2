# skills-audience-segment-designer-v2

ウェブ広告向けの**オーディエンスセグメント設計** Skill と、Cursor / Claude 用の補助スキルをまとめたリポジトリです。ファイルは役割ごとにフォルダへ分割してあります。

---

## フォルダ構成と役割

| パス | 役割 |
|------|------|
| **`library/reference-md/audience-segment-designer/`** | オーディエンス設計スキルが参照する**ドメイン知識の正規ソース**（ビジネスモデル型マップ、5seg ロジック、媒体別設定観点、クライアント向けブリーフ要素など）。編集・差し替えは基本ここだけ行えばよい。 |
| **`skill-package/`** | **Claude.ai（Web）へアップロードするときのパッケージ**として使うフォルダ。リポジトリ上は `skills/audience-segment-designer/` へのシンボリックリンクであり、中身は同一。ZIP 化する際はリンク先の実ファイルがアーカイブに含まれるよう注意（下記「Claude.ai」参照）。 |
| **`skills/audience-segment-designer/`** | **メイン Skill の実体**（開発・Git 管理の正規パス）。`SKILL.md` に概要・入力・フロー・禁止事項があり、手順の詳細は `references/` 内の分割ファイルに記載。Cursor / Claude Code は主にここを参照。 |
| **`skills/audience-segment-designer/references/`** | 実行手順（STEP1〜4）の分割ドキュメントと、上記 `library/` への**シンボリックリンク**。スキル実行時はここ経由で参照する。 |
| **`skills/extra/`** | オーディエンス設計以外の**汎用・投資ワークフロー用**などの補助スキル（`code-review`、`learn`、各投資テンプレート等）。必要なものだけ Claude / 別プロジェクトにコピー可能。 |
| **`.cursor/skills/`** | Cursor が読み込むスキル置き場。**各エントリは `skills/` へのシンボリックリンク**（メインは `audience-segment-designer`、その他は `skills/extra/*`）。 |
| **`.claude/skills/`** | Claude Code がプロジェクト単位で読むスキル置き場。`audience-segment-designer` は `skills/audience-segment-designer` へのリンク。 |
| **ルート `README.md`** | 本ドキュメント（リポジトリの地図と利用手順）。 |
| **ルート `SKILL.md` / `references/`** | `skills/audience-segment-designer/` への**シンボリックリンク**。エディタや旧手順からルートだけ触りたい場合のエイリアス。 |

### ディレクトリツリー（要点）

```text
skill-package/                      ← Claude.ai へ ZIP アップロードするときの「パッケージ名」（→ skills/audience-segment-designer）

library/
└── reference-md/
    └── audience-segment-designer/    ← 参照用 .md の実体（正規ソース）
        ├── bm-segment-axis-map.md
        ├── 5seg-segment-logic.md
        ├── client-summary-template.md
        ├── google-ads-audience-settings.md
        └── meta-ads-audience-settings.md

skills/
├── audience-segment-designer/        ← メイン Skill の実体
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

scripts/
└── build-claude-skill-zip.sh         ← リンクを解決した skill-package 用 ZIP を生成（任意）

.cursor/skills/   → 上記 skills へのシンボリックリンク群
.claude/skills/   → Claude Code 用（メインスキルへのリンク）
```

---

## Claude（Agent Skills）への取り込み方

Anthropic の Agent Skills は、**フォルダ 1 つ = スキル 1 つ**で、その直下に必ず `SKILL.md` があります。

**Claude.ai（ブラウザ）で運用するときの操作**は、次のとおり **`skill-package` を ZIP にしてアップロード**する流れを前提にしています（パッケージの実体は `skills/audience-segment-designer/` と同一です）。

### 取り込み先の違い

| 利用環境 | 操作の要点 | 向いている用途 |
|----------|------------|----------------|
| **Claude.ai**（Web） | **`skill-package` を ZIP 化**し、Settings からアップロード | チャット上でスキルを効かせたいとき |
| **Claude Code** | `~/.claude/skills/` または **プロジェクト**の `.claude/skills/` にスキルフォルダを置く | リポジトリを開いて実行するとき |

公式: [Agent Skills（Claude Docs）](https://code.claude.com/docs/en/skills)

### A. Claude.ai（`skill-package` の ZIP アップロード）

1. **ZIP に含めるフォルダ**は **`skill-package`** です（リポジトリ直下。`skills/audience-segment-designer` へのシンボリックリンク）。  
2. **`SKILL.md` と `references/` 以下の全ファイル**が ZIP 内に実体として入っていることを確認する。  
   - `references/` 内にシンボリックリンクがあるため、**そのまま `skill-package` を圧縮するとリンクだけが入り、Claude 側で参照が壊れる**ことがあります。  
   - **推奨**: リポジトリルートで次を実行し、リンクを解決した ZIP を作る。  
     ```bash
     ./scripts/build-claude-skill-zip.sh
     ```  
     出力は既定で **`dist/skill-package.zip`**（中身は `skill-package/SKILL.md` 形式。必ずこのスクリプトで作ること）。  
   - **手動の場合**: `skill-package` と同じ構成で一時フォルダを作り、`SKILL.md` と `references/*.md` を**コピー**（リンク先の中身がコピーされるよう OS の機能や `cp -L` 等を使う）してから、そのフォルダを `skill-package` という名前で ZIP する。  
3. Claude の **Settings → Features → Skills**（名称は製品版で変わる場合あり）から、その ZIP をアップロードする。  
4. 依頼文は `SKILL.md` の description に近い表現にすると発動しやすいです。

### B. Claude Code（このリポジトリをそのまま使う）

- **`.claude/skills/audience-segment-designer`** が `skills/audience-segment-designer`（＝ `skill-package` と同じ実体）を指しています。プロジェクトルートで Claude Code を開けば読み込まれます。  
- グローバルに使う場合は `skills/audience-segment-designer/` を `~/.claude/skills/` にコピー、またはシンボリックリンクで追加。  
- **補助スキル**は `skills/extra/<スキル名>/` を同様にコピーまたはリンクしてください。

**Windows 等でシンボリックリンクが使えない場合**は、`skills/audience-segment-designer/` または `skills/extra/<名前>/` をそのままコピーして配置してください。

### トラブルシュート: macOS で `skill-package.zip` を展開できない（エラー 512 など）

macOS の**アーカイブユーティリティ**（ダブルクリック展開）は、作成ツールや中身によって「展開できません（**エラー 512**）」と出ることがあります。**ZIP 自体が壊れているとは限りません。**

1. **本リポジトリで用意した ZIP を使う**  
   手作りの圧縮や、**リポジトリ全体の「GitHub の Download ZIP」**はスキル用の構成になっていません。必ず `./scripts/build-claude-skill-zip.sh` の出力（既定は `dist/skill-package.zip`）を使うか、手順どおりに実ファイルだけを入れた `skill-package` を ZIP してください。

2. **ターミナルで展開する**（Finder より確実なことが多い）  
   ```bash
   unzip -l ~/path/to/skill-package.zip    # 中身の確認（skill-package/SKILL.md があるか）
   unzip -o ~/path/to/skill-package.zip -d ~/Desktop
   ```  
   `skill-package` フォルダがデスクトップ等に展開されます。

3. **シンボリックリンク入りの `skill-package` をそのまま圧縮した ZIP**は、環境によっては展開や Claude 側の解釈で失敗します。**スクリプトでリンクを解決した ZIP を使う**のが安全です。

4. **展開先のパス**にスペースや特殊文字が多いと失敗することがあるため、一度 **`~/Desktop`** など短いパスに `unzip -d` して試してください。

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
2. **Claude.ai** の場合は上記どおり **`skill-package` の ZIP をアップロード**済みにする。**Cursor / Claude Code** の場合はスキルを有効にする（上記「取り込み方」）。  
3. セグメント設計の依頼をする。  
4. ①② をレビューし、必要なら `library/reference-md/` の媒体別ガイドと突き合わせる。

---

## ライセンス・免責

利用条件は必要に応じて整備してください。`skills/extra/` の投資関連スキルは分析・整理用テンプレートであり、投資勧誘ではありません。
