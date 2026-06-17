#!/bin/bash

# Claude Code statusline
# - 時刻 / モデル / effort / context / rate limit (5h) / agmsg name / セッション経過 / 出力スタイル

input=$(cat)

# ANSI colors
R=$'\033[0m'
DIM=$'\033[2m'
BOLD=$'\033[1m'
CYAN=$'\033[36m'
BLUE=$'\033[94m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
ORANGE=$'\033[38;5;208m'
RED=$'\033[31m'
MAGENTA=$'\033[95m'
GRAY=$'\033[90m'

# 時刻
time_info="${CYAN}󰥔 $(date +%H:%M:%S)${R}"

# モデル
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')
model_info="${BLUE}󰧑 ${model_name}${R}"

# effort（/effort のカラー: low=緑 / medium=黄 / high=橙 / xhigh=赤 / max=マゼンタ）
effort_level=$(echo "$input" | jq -r '.effort.level // empty')
if [ -n "$effort_level" ]; then
  case "$effort_level" in
    low)    effort_color="$GREEN" ;;
    medium) effort_color="$YELLOW" ;;
    high)   effort_color="$ORANGE" ;;
    xhigh)  effort_color="$RED" ;;
    max)    effort_color="$MAGENTA" ;;
    *)      effort_color="$R" ;;
  esac
  effort_info="${effort_color}󱐋 ${effort_level}${R}"
else
  effort_info=""
fi

# Context 使用率
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
  used_pct_int=$(printf "%.0f" "$used_pct")
  remaining=$((100 - used_pct_int))
  if   [ $remaining -ge 75 ]; then ctx_icon="󰁹"; ctx_color="$GREEN"
  elif [ $remaining -ge 50 ]; then ctx_icon="󰂀"; ctx_color="$GREEN"
  elif [ $remaining -ge 25 ]; then ctx_icon="󰁾"; ctx_color="$YELLOW"
  else                              ctx_icon="󰁻"; ctx_color="$RED"
  fi
  context_info="${ctx_color}${ctx_icon} ${used_pct_int}%${R}"
else
  context_info="${GRAY}󰁹 --${R}"
fi

# Rate limit (5h window) — Pro/Max のみ、初回 API 応答後に出現
rl_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rl_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$rl_pct" ]; then
  rl_pct_int=$(printf "%.0f" "$rl_pct")
  if   [ $rl_pct_int -lt 50 ]; then rl_color="$GREEN"
  elif [ $rl_pct_int -lt 75 ]; then rl_color="$YELLOW"
  elif [ $rl_pct_int -lt 90 ]; then rl_color="$ORANGE"
  else                              rl_color="$RED"
  fi
  if [ -n "$rl_resets" ]; then
    reset_hm=$(date -r "$rl_resets" +%H:%M 2>/dev/null || date -d "@$rl_resets" +%H:%M 2>/dev/null)
    rl_info="${rl_color}󰓅 ${rl_pct_int}%${R} ${DIM}→${reset_hm}${R}"
  else
    rl_info="${rl_color}󰓅 ${rl_pct_int}%${R}"
  fi
else
  rl_info=""
fi

# agmsg agent name（トークン消費なし・ローカル SQLite）
agmsg_info=""
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
whoami_script="$HOME/.agents/skills/agmsg/scripts/whoami.sh"
if [ -x "$whoami_script" ] && [ -n "$cwd" ]; then
  whoami_out=$("$whoami_script" "$cwd" claude-code 2>/dev/null)
  agmsg_name=$(echo "$whoami_out" | grep -oE '(^|[[:space:]])agent=[^[:space:]]+' | head -1 | sed 's/.*agent=//')
  agmsg_team=$(echo "$whoami_out" | grep -oE '(^|[[:space:]])teams=[^[:space:]]+' | head -1 | sed 's/.*teams=//')
  if [ -n "$agmsg_name" ]; then
    if [ -n "$agmsg_team" ]; then
      agmsg_info="${MAGENTA}󰚩 ${agmsg_name}${R}${DIM}@${agmsg_team}${R}"
    else
      agmsg_info="${MAGENTA}󰚩 ${agmsg_name}${R}"
    fi
  fi
fi

# Claude Code が渡す agent 名（subagent 動作中のみ）
sub_agent=$(echo "$input" | jq -r '.agent.name // empty')
if [ -n "$sub_agent" ]; then
  sub_agent_info="${MAGENTA}󰚩 ${sub_agent}${R}"
else
  sub_agent_info=""
fi

# セッション経過時間
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
session_time=""
if [ -f "$transcript_path" ]; then
  session_start=$(stat -f %B "$transcript_path" 2>/dev/null || stat -c %W "$transcript_path" 2>/dev/null)
  if [ -n "$session_start" ] && [ "$session_start" != "0" ]; then
    elapsed=$(( $(date +%s) - session_start ))
    h=$((elapsed / 3600))
    m=$(((elapsed % 3600) / 60))
    if [ $h -gt 0 ]; then session_time="${h}h${m}m"; else session_time="${m}m"; fi
  fi
fi
if [ -n "$session_time" ]; then
  session_info="${GRAY}󰔟 ${session_time}${R}"
else
  session_info=""
fi

# 出力スタイル（default 以外）
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
  style_info="${GRAY}󰏘 ${output_style}${R}"
else
  style_info=""
fi

# 組み立て（2行: 1行目=状態, 2行目=識別）
line1=("$time_info" "$context_info")
[ -n "$rl_info" ]         && line1+=("$rl_info")
[ -n "$session_info" ]    && line1+=("$session_info")

line2=("$model_info")
[ -n "$effort_info" ]     && line2+=("$effort_info")
[ -n "$agmsg_info" ]      && line2+=("$agmsg_info")
[ -n "$sub_agent_info" ]  && line2+=("$sub_agent_info")
[ -n "$style_info" ]      && line2+=("$style_info")

sep="${GRAY} | ${R}"
printf "%s" "${line1[0]}"
for ((i=1; i<${#line1[@]}; i++)); do printf "%s%s" "$sep" "${line1[$i]}"; done
printf "\n%s" "${line2[0]}"
for ((i=1; i<${#line2[@]}; i++)); do printf "%s%s" "$sep" "${line2[$i]}"; done
