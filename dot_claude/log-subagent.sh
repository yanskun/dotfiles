#!/bin/bash
# SubagentStop hook: サブエージェント使用ログを記録
# 入力: stdin から JSON (agent_type, agent_id, session_id 等)

LOG_FILE="$HOME/.claude/subagent-usage.log"

if command -v jq &> /dev/null; then
  jq -c '{ts: (now | todate), type: .agent_type, id: .agent_id, session: .session_id}' >> "$LOG_FILE"
else
  echo "{\"ts\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"type\":\"unknown\"}" >> "$LOG_FILE"
fi
