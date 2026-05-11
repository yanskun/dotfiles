---
name: pr-create
description: GitHub CLI を使った PR 作成
allowed-tools: Bash(gh pr create -a @me:*), Bash(open https://github.com:*), Bash(git checkout -b:*), Bash(git branch:*)
---

# PR 作成ルール

## 0. ブランチ名の確認

現在のブランチが [Semantic Branch Names](https://gist.github.com/seunggabi/87f8c722d35cd07deb3f649d45a31082) に沿っていない場合（例: `worktree-xxx`、`main`、`master` など）、PR 作成前に適切なプレフィックス付きのブランチへ切り直すこと。

```bash
git checkout -b feat/<description>
```

プレフィックスの例:

- `feat/` 新機能
- `fix/` バグ修正
- `docs/` ドキュメント
- `refactor/` リファクタリング
- `chore/` その他
- `test/` テスト
- `hotfix/` 緊急修正（`--base main` 必須）

## 1. Draft PR

引数に `draft` が指定された場合、`gh pr create` に `--draft` フラグを付与すること。

```bash
gh pr create -a @me --draft
```

## 2. セマンティックコミットメッセージに準拠

PR タイトルは Conventional Commits の形式に従うこと。

- `feat: 新機能の説明`
- `fix: バグ修正の説明`
- `docs: ドキュメント変更の説明`
- `refactor: リファクタリングの説明`
- `chore: その他の変更の説明`
- `test: テスト関連の変更の説明`

## 3. Hotfix は `--base main` を指定

Hotfix ブランチ（`hotfix/` プレフィックス）の場合は、必ず `--base main` を付与すること。

```bash
gh pr create -a @me --base main
```

## 4. PR Body の作成

コミットメッセージと差分から以下の構成で PR Body を生成すること。

```markdown
## Summary

<変更内容を1〜3行で要約>

## Test plan

<コミットメッセージと差分から推察されるテスト確認項目をチェックリストで記載>
```

## 5. PR 作成後にブラウザで開く

PR 作成が完了したら、返却された PR URL をブラウザで開くこと。

```bash
open <PR_URL>
```
