#!/bin/bash
# PreToolUse(Skill) hook: Skill 呼び出しログを記録
# 入力: stdin から JSON (tool_input.skill, session_id, cwd 等)
# 注: Skill tool のパラメータ名は `skill`。旧コードは `skill_name` を見ていて
#     全件 "unknown" になっていた (2026-06-16 修正)。

LOG_FILE="$HOME/.claude/skill-usage.log"

if command -v jq &> /dev/null; then
  jq -c '{ts: (now | todate), skill: (.tool_input.skill // .tool_input.skill_name // "unknown"), args: (.tool_input.args // null), session: .session_id, cwd: .cwd}' >> "$LOG_FILE"
else
  echo "{\"ts\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"skill\":\"unknown\"}" >> "$LOG_FILE"
fi

# PreToolUse hook は非ゼロ終了でツールをブロックしうるため必ず 0 で抜ける
exit 0
