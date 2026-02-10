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
    session_time=""
  fi
else
  session_time=""
fi

# コンテキスト使用率を取得
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  # 小数点以下を切り捨て
  used_pct_int=$(printf "%.0f" "$used_pct")

  # 残量を計算（100% - 使用率）
  remaining=$((100 - used_pct_int))

  # 残量に応じてバッテリーアイコンを選択
  if [ $remaining -ge 75 ]; then
    battery_icon="󰁹"  # battery_full
  elif [ $remaining -ge 50 ]; then
    battery_icon="󰂀"  # battery_three_quarters
  elif [ $remaining -ge 25 ]; then
    battery_icon="󰁾"  # battery_half
  else
    battery_icon="󰁻"  # battery_quarter
  fi

  context_info="$battery_icon ${used_pct_int}%"
else
  context_info="󰁹 0%"
fi

# エージェント名を取得（存在する場合）
agent_name=$(echo "$input" | jq -r '.agent.name // empty')
if [ -n "$agent_name" ]; then
  agent_info="󰚩 $agent_name"
else
  agent_info=""
fi

# モデル名を取得
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')

# 出力スタイルを取得
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
  style_info="󰏘 $output_style"
else
  style_info=""
fi

# 現在時刻を取得
current_timestamp=$(date +%H:%M:%S)

# ステータスラインを構築（セパレータで区切る）
status_parts=()
status_parts+=("󰥔 $current_timestamp")

if [ -n "$session_time" ]; then
  status_parts+=("󰔟 $session_time")
fi

status_parts+=("$context_info")

if [ -n "$agent_info" ]; then
  status_parts+=("$agent_info")
fi

status_parts+=("󰧑 $model_name")

if [ -n "$style_info" ]; then
  status_parts+=("$style_info")
fi

# 配列を " | " で結合
printf "%s" "${status_parts[0]}"
for ((i=1; i<${#status_parts[@]}; i++)); do
  printf " | %s" "${status_parts[$i]}"
done
