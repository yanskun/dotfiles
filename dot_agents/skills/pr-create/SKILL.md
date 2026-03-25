---
name: GitHub PR Create
description: GitHub CLI を使った PR 作成
allowed-tools: Bash(gh pr create -a @me:*), Bash(open https://github.com:*)
---

# PR 作成ルール

## 1. セマンティックコミットメッセージに準拠

PR タイトルは Conventional Commits の形式に従うこと。

- `feat: 新機能の説明`
- `fix: バグ修正の説明`
- `docs: ドキュメント変更の説明`
- `refactor: リファクタリングの説明`
- `chore: その他の変更の説明`
- `test: テスト関連の変更の説明`

## 2. Hotfix は `--base main` を指定

Hotfix ブランチ（`hotfix/` プレフィックス）の場合は、必ず `--base main` を付与すること。

```bash
gh pr create -a @me --base main
```

## 3. PR Body の作成

コミットメッセージと差分から以下の構成で PR Body を生成すること。

```markdown
## Summary

<変更内容を1〜3行で要約>

## Test plan

<コミットメッセージと差分から推察されるテスト確認項目をチェックリストで記載>
```

## 4. PR 作成後にブラウザで開く

PR 作成が完了したら、返却された PR URL をブラウザで開くこと。

```bash
open <PR_URL>
```
