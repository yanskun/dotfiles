---
allowed-tools:
  - Bash(git worktree list)
  - Bash(git worktree remove:*)
  - Bash(git worktree prune:*)
  - Bash(git status:*)
  - Bash(git log:*)
  - Bash(git diff:*)
  - Bash(git branch:*)
  - Bash(ls:*)
  - Bash(test:*)
  - Bash(rm -rf .claude/worktrees/:*)
description: .claude/worktrees/ 配下の不要 worktree を分類して安全に削除する
---

`.claude/worktrees/` を以下の3カテゴリに分類して整理する。破壊前に必ずユーザー確認を取る。

## カテゴリ

| カテゴリ | 判定 | 削除方法 |
|---|---|---|
| **A. 登録済み worktree** | `git worktree list` に出る | `git worktree remove --force <path>` |
| **B. orphan ディレクトリ** | ディレクトリは存在するが `git worktree list` に無い | `rm -rf <path>` |
| **C. 壊れたエントリ** | `.git/worktrees/<name>` に残骸あり / `git -C <path> status` が fatal | `git worktree prune -v` + `rm -rf <path>`（残ってれば） |

## 引数

- `$ARGUMENTS` に keep 対象の worktree 名（スペース区切り）。例: `/cleanup-worktrees foo bar`
- 引数なし → カテゴリ別の現状をレポートし、どれを残すかユーザーに確認

## 手順

1. **棚卸し**: `ls .claude/worktrees/` と `git worktree list` を取って 3 カテゴリに分類する。
2. **A の安全確認**: 削除対象の登録済み worktree それぞれについて
   - `git -C <path> status --short` で未コミット変更・untracked を確認
   - `git -C <path> log --oneline <branch> ^develop` で unique commit を確認
   - 未コミット変更や unique commit があれば**個別にユーザー確認**。特に新規ディレクトリの untracked は要注意（実作業の可能性）
3. **プラン提示**: 「カテゴリ別の削除対象一覧 + 懸念事項」をまとめてユーザー承認を待つ
4. **実行**:
   - A: `git worktree remove --force <path>`
   - C: `git worktree prune -v` で .git/worktrees エントリ掃除
   - B + C残骸: `rm -rf .claude/worktrees/<name>`
5. **検証**: `ls .claude/worktrees/` と `git worktree list` の整合を確認
6. **Follow-up 提示**: 死んだローカルブランチ候補（`origin gone` / unique commit 無し）を列挙。**自動削除はしない**

## 禁則

- 未コミット変更がある worktree をユーザー確認なしに `--force` 削除してはいけない
- ローカルブランチの削除を勝手にしない（提示のみ）
- メインリポ自体や、`.claude/worktrees/` 以外のディレクトリには触れない
