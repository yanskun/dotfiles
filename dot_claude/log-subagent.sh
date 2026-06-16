#!/bin/bash
# SubagentStop hook: サブエージェント使用ログを記録
#
# Claude Code が SubagentStop hook に渡す payload のフィールド名は版で揺れる。
# 既知の候補:
#   - agent_type / subagent_type / type
#   - agent_id   / subagent_id   / id
#   - model
#   - parent_subagent_id（Workflow 由来かどうかの判別に使える可能性）
#
# 2026-06-16 改修:
#   - 旧 payload 仮説 (.agent_type) は全件空文字 → 揺れに耐える `//` 連鎖に変更
#   - raw payload を別ファイルに一時保存して実フィールドを観察できるようにする
#     (RAW_FILE は 200 件キャップで自動ローテート)

LOG_FILE="$HOME/.claude/subagent-usage.log"
RAW_FILE="$HOME/.claude/subagent-raw.log"
RAW_KEEP=200

payload=$(cat)

if command -v jq &> /dev/null; then
  echo "$payload" | jq -c '{
    ts: (now | todate),
    type: (.subagent_type // .agent_type // .type // ""),
    id: (.subagent_id // .agent_id // .id // ""),
    model: (.model // .subagent_model // null),
    parent: (.parent_subagent_id // .parent_id // null),
    session: .session_id
  }' >> "$LOG_FILE"

  # raw payload を末尾に append しつつローテート
  echo "$payload" | jq -c '{ts: (now | todate), payload: .}' >> "$RAW_FILE"
  if [ -f "$RAW_FILE" ]; then
    tail -n "$RAW_KEEP" "$RAW_FILE" > "$RAW_FILE.tmp" && mv "$RAW_FILE.tmp" "$RAW_FILE"
  fi
else
  echo "{\"ts\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"type\":\"unknown\"}" >> "$LOG_FILE"
fi

exit 0
