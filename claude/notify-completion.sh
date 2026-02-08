#!/bin/bash
# Claude Code の応答完了時に実行される通知スクリプト

LOG_FILE="$HOME/.claude/notify.log"

echo "[$(date)] Hook triggered" >> "$LOG_FILE"

# Repository 名を取得
REPO_NAME=""
if git rev-parse --show-toplevel &> /dev/null; then
  REPO_NAME=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
fi

# tmux window name を取得（Repository がない場合のみ）
TMUX_WINDOW=""
if [ -z "$REPO_NAME" ] && [ -n "$TMUX" ]; then
  TMUX_WINDOW=$(tmux display-message -p '#W' 2>/dev/null)
fi

# 通知メッセージを構築
MESSAGE="応答が完了しました"
if [ -n "$REPO_NAME" ]; then
  MESSAGE="$MESSAGE\n📁 $REPO_NAME"
elif [ -n "$TMUX_WINDOW" ]; then
  MESSAGE="$MESSAGE\n🪟 $TMUX_WINDOW"
fi

# terminal-notifier で通知を送信
if command -v terminal-notifier &> /dev/null; then
  echo "[$(date)] Sending notification: $MESSAGE" >> "$LOG_FILE"
  terminal-notifier -title "Claude Code" -message "$MESSAGE" 2>> "$LOG_FILE"

  # 通知と同時に音を鳴らす
  if command -v afplay &> /dev/null; then
    afplay /System/Library/Sounds/Glass.aiff &
    echo "[$(date)] Notification and sound sent successfully" >> "$LOG_FILE"
  else
    echo "[$(date)] Notification sent (no sound)" >> "$LOG_FILE"
  fi
  exit 0
fi

# フォールバック: システムサウンドを鳴らす
if command -v afplay &> /dev/null; then
  echo "[$(date)] Playing sound with afplay" >> "$LOG_FILE"
  afplay /System/Library/Sounds/Glass.aiff &
  echo "[$(date)] Sound playback initiated" >> "$LOG_FILE"
  exit 0
fi

# 最終フォールバック: ビープ音
echo "[$(date)] Using beep as last resort" >> "$LOG_FILE"
printf '\a'
exit 0
