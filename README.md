# skills-audience-segment-designer-v2

ウェブ広告（Google / Meta 等）向けの**オーディエンスセグメント設計**を、再現性のある手順で進めるための Skill 定義です。リポジトリ内の**正規の Skill パッケージ**は `skills/audience-segment-designer/` にあります（ルートの `SKILL.md` はそこへのシンボリックリンクです）。

---

## Claude（Agent Skills）への取り込み方

Anthropic の Agent Skills は、**フォルダ 1 つ = スキル 1 つ**で、その直下に必ず `SKILL.md` があります。本プロジェクトでは **`skills/audience-segment-designer/` がその単位**です（`references/` 付き）。

### 取り込み先の違い（どれを使うか）

| 利用環境 | スキルを置く場所 | 向いている用途 |
|----------|------------------|----------------|
| **Claude.ai**（Web） | ブラウザの設定から ZIP をアップロード | チャット上でスキルを効かせたいとき |
| **Claude Code**（CLI / IDE） | ユーザーレベル `~/.claude/skills/` または **プロジェクト**の `.claude/skills/` | リポジトリを開いて開発・実行するとき |

公式の概要は [Agent Skills（Claude Docs）](https://code.claude.com/docs/en/skills) を参照してください（UI やパスはアップデートされることがあります）。

### A. Claude.ai に取り込む（ZIP）

1. 次の**フォルダだけ**を ZIP に固める（**中身の `SKILL.md` と `references/` が入っていればよい**）:  
   `skills/audience-segment-designer/`
2. Claude の **Settings → Features → Skills**（名称は製品版で変わる場合あり）から、その ZIP をアップロードする。
3. チャットで、セグメント設計の依頼をする（`SKILL.md` の description にあるトリガーに近い表現だと検出されやすいです）。

アップロードできるのは **Pro / Max / Team / Enterprise** など、プランによって制限があります。最新の条件は公式の案内に従ってください。

### B. Claude Code に取り込む（フォルダ配置）

**方式 1: このリポジトリをそのまま使う（推奨）**

- リポジトリ直下に **`.claude/skills/audience-segment-designer`** があり、`skills/audience-segment-designer/` へのシンボリックリンクになっています。
- このプロジェクトを Claude Code のカレントディレクトリにした状態で作業すると、**プロジェクトレベルのスキル**として読み込まれます。

**方式 2: 手元のグローバルに入れる**

- `skills/audience-segment-designer/` フォルダごとコピーし、`~/.claude/skills/audience-segment-designer/` に置く。  
- どのリポジトリでも同じスキルを使いたいとき向けです。

**方式 3: シンボリックリンク（上級者）**

- `ln -s /絶対パス/skills/audience-segment-designer ~/.claude/skills/audience-segment-designer`  
- Git 管理したスキルを 1 か所に置きつつ、更新を共有したい場合に便利です。

### 補足スキル（コードレビュー・投資テンプレ等）

`.cursor/skills/` には、オーディエンス設計以外のテンプレートも同梱しています。**Claude Code で使う場合**は、使いたいフォルダだけを `~/.claude/skills/` にコピーするか、同様にシンボリックリンクで追加してください（フォルダ名がそのままスキル名になります）。

**Windows 等でリポジトリ内のシンボリックリンクが展開されない場合**は、`skills/audience-segment-designer/` をそのままコピーして `~/.claude/skills/audience-segment-designer/` に置くか、ZIP 作成対象として同フォルダだけを選んでください。

---

## フォルダ構成（全体像）

```text
skills/
└── audience-segment-designer/     ← Claude に渡す単位（ZIP もこれ）
    ├── SKILL.md                   ← 本体（v4.1）
    └── references/                ← ビジネスモデル型マップ、5seg、Google/Meta 配信観点など

.claude/skills/
└── audience-segment-designer  →  ../../skills/audience-segment-designer   （Claude Code 用シンボリックリンク）

.cursor/skills/
├── audience-segment-designer  →  ../../skills/audience-segment-designer   （Cursor 用。上と同じ参照先）
├── code-review/
├── learn/
└── …                             （その他テンプレート）

SKILL.md              →  skills/audience-segment-designer/SKILL.md   （ルートから開きやすいようリンク）
references/           →  skills/audience-segment-designer/references （同上）

（ルートの *.md は references から参照される実体ファイル）
```

- **Cursor** 利用時: `.cursor/skills/` 以下のスキルがエージェントに読み込まれます。  
- **Claude** 利用時: 上表のとおり `skills/audience-segment-designer/` または `.claude/skills/` 経由で取り込みます。

---

## この Skill が出力するもの（最終成果物は 2 点だけ）

| # | 成果物 | 形式 | 用途 |
|---|--------|------|------|
| ① | エグゼクティブ向けセグメントブリーフ | `.md` | 意思決定者向け。設計の全体像を初見で把握できるようにまとめる |
| ② | 広告配信設定 Excel | `.xlsx` | 運用担当向け。管理画面への入稿に使うオーディエンス設定を 1 ファイルに集約 |

ファイル名の例（`SKILL.md` 内の命名規則に準拠）:

- `executive-segment-brief-[クライアント名]-[対象5seg].md`
- `ad-delivery-settings-[クライアント名]-[対象5seg].xlsx`

## 内部でおこなうこと（概要）

入力を整理したうえで、おおよそ次の順で設計します（詳細は `skills/audience-segment-designer/SKILL.md`）。

1. **STEP1** — 入力の整理・課題の構造化  
2. **STEP2-0〜2-5** — ビジネスモデル型（39 型）に沿ったセグメント軸の絞り込み（任意）→ セグメント洗い出し → 収益性×規模×成長性の評価 → 優先度 → 原因仮説・媒体マップ  
3. **STEP3** — ① エグゼクティブ向けブリーフの作成  
4. **STEP4** — ② 配信設定 Excel の作成（Google / Meta シート等）

5seg（ロイヤル / 一般 / トライアル / 未顧客 / 離脱）のどこを対象にするかが確定すると、`references/5seg-segment-logic.md` に基づき推奨軸や失敗パターンを反映します。

## 入力について（必読）

`SKILL.md` は、**ビジネス分析と 5seg 分析の結果をすでに持っている前提**で進めると精度と速度が出ます。エージェントや AI に渡すときは、次を **Markdown で添付・貼り付け**してください。

| 順 | 内容 | 必須 |
|----|------|------|
| 1 | **ビジネス分析**を実施したうえで出力した `.md`（事業概要、課題、競合、収益構造など分析内容が分かるもの） | 推奨 |
| 2 | **5seg 分析**を実施したうえで出力した `.md`（セグメント定義・課題・優先度などが分かるもの） | 推奨 |

### 5seg まわりの入力の扱い

- **厳密な「5seg 分析レポートの md」でなくても構いません。**  
- 5seg に沿った課題設定と解決提案が一体になった**提案資料**（提案書・スライドを md にしたもの、議事メモとセットなど）で、**どのセグメントをどう改善するかが読み取れる**のであれば入力として利用できます。

### 手法・テンプレートの参照

フレームの詳細や教材側の手順は、[Method Library（フルスタックマーケター育成講座）](https://method-library.kandoasia.com/) を参照してください。本 Skill は同ライブラリの分析を**入力として受け取り**、広告オーディエンス設計に落とし込む用途を想定しています。

### `SKILL.md` 内の直接入力（テンプレート）

分析 md がない場合でも、`SKILL.md` の「入力テンプレート」（サービス情報・課題・対象 5seg 等）に沿ってチャットで埋めていく運用が可能です。ただし **【1】【2】【4】は必須**です。

## 使い方の目安（ツール共通）

1. 上記の**ビジネス分析 md** と **5seg 分析 md**（または 5seg に相当する課題解決型の提案資料）を用意する。  
2. **Claude** では上記「取り込み方」に従いスキルを有効にする。**Cursor** では本リポジトリを開き、`.cursor/skills/` 経由で同じ定義を読める。  
3. 「セグメント設計して」「対象は離脱」など、`SKILL.md` の description に近い依頼をする。  
4. 出力された ①② をレビューし、必要なら `references/` の媒体別設定ガイドと突き合わせる。

## ライセンス・免責

リポジトリの利用条件は必要に応じて整備してください。`.cursor/skills/` に含まれる投資関連スキルは分析・整理用途のテンプレートであり、投資勧誘ではありません。
