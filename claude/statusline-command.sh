#!/bin/bash

# Claude Code用のカスタムステータスライン
# JSON入力を読み取る
input=$(cat)

# セッション開始時間を取得
transcript_path=$(echo "$input" | jq -r '.transcript_path')
if [ -f "$transcript_path" ]; then
  session_start=$(stat -f %B "$transcript_path" 2>/dev/null || stat -c %W "$transcript_path" 2>/dev/null)
  if [ -n "$session_start" ]; then
    current_time=$(date +%s)
    elapsed=$((current_time - session_start))
    hours=$((elapsed / 3600))
    minutes=$(((elapsed % 3600) / 60))
    if [ $hours -gt 0 ]; then
      session_time="${hours}h${minutes}m"
    else
      session_time="${minutes}m"
    fi
  else
    session_time="N/A"
  fi
else
  session_time="N/A"
fi

# コンテキスト使用率を取得
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  # 小数点以下を切り捨て
  used_pct_int=$(printf "%.0f" "$used_pct")
  context_info="Ctx: ${used_pct_int}%"
else
  context_info="Ctx: 0%"
fi

# エージェント名を取得（存在する場合）
agent_name=$(echo "$input" | jq -r '.agent.name // empty')
if [ -n "$agent_name" ]; then
  agent_info="Agent: $agent_name"
else
  agent_info=""
fi

# モデル名を取得
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# 出力スタイルを取得
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
  style_info="Style: $output_style"
else
  style_info=""
fi

# ステータスラインを構築（セパレータで区切る）
status_parts=()
status_parts+=("Session: $session_time")
status_parts+=("$context_info")

if [ -n "$agent_info" ]; then
  status_parts+=("$agent_info")
fi

status_parts+=("$model_name")

if [ -n "$style_info" ]; then
  status_parts+=("$style_info")
fi

# 配列を " | " で結合
printf "%s" "${status_parts[0]}"
for ((i=1; i<${#status_parts[@]}; i++)); do
  printf " | %s" "${status_parts[$i]}"
done
