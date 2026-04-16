#!/bin/bash
file_path=$(jq -r '.tool_input.file_path // empty')
[ -z "$file_path" ] && exit 0
case "$file_path" in
  "$CLAUDE_PROJECT_DIR"/*) exit 0 ;;
  *)
    echo "Blocked: $file_path is outside worktree ($CLAUDE_PROJECT_DIR). Use the worktree-prefixed path." >&2
    exit 2 ;;
esac
