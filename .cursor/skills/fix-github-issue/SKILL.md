---
name: fix-github-issue
description: GitHub Issue を分析し、修正方針の整理・実装・テストまで進める。Issue 番号や URL が渡されたとき、または /fix-github-issue で明示呼び出しされたときに使用。
disable-model-invocation: true
---

# Fix GitHub Issue

GitHub Issue: $ARGUMENTS を分析して修正する。

## 手順

1. `gh issue view` で Issue の詳細を取得する
2. 問題を理解する
3. 関連ファイルをコードベースから検索する
4. 修正を実装する
5. テストを書いて実行する
6. lint・型チェックを通す
7. コミットメッセージを作成する
8. プッシュして PR を作成する（ユーザー方針に合わせる）
