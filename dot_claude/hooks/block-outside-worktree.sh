#!/bin/bash
# worktree の中にいるときだけブロックする（メイン作業ツリーではスキップ）
git_dir=$(git rev-parse --git-dir 2>/dev/null)
git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
[ "$git_dir" = "$git_common_dir" ] && exit 0   # メインツリー → 制限なし

file_path=$(jq -r '.tool_input.file_path // empty')
[ -z "$file_path" ] && exit 0

worktree_root=$(git rev-parse --show-toplevel 2>/dev/null)
[ -z "$worktree_root" ] && exit 0

# harness-learning (/learn) の反映先。chezmoi ソースの harness 定義領域への
# 書き込みは worktree の外でも常に許可する（/learn は主 worktree の chezmoi
# ソースに学びを焼き込む運用のため）。
harness_root="$HOME/.local/share/chezmoi"

case "$file_path" in
  "$worktree_root"/*) exit 0 ;;
  "$harness_root"/dot_claude/*|"$harness_root"/dot_agents/*|"$harness_root"/docs/superpowers/*|"$harness_root"/.chezmoitemplates/*)
    exit 0 ;;
  *)
    echo "Blocked: $file_path is outside worktree ($worktree_root). Use the worktree-prefixed path." >&2
    exit 2 ;;
esac
