#!/bin/bash
# Claude Code の通知スクリプト
# Usage: notify-completion.sh [stop|notification]

HOOK_TYPE="${1:-stop}"
LOG_FILE="$HOME/.claude/notify.log"

echo "[$(date)] Hook triggered: $HOOK_TYPE" >> "$LOG_FILE"

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

# 通知タイプに応じてメッセージとサウンドを設定
case "$HOOK_TYPE" in
  notification)
    TITLE="Claude Code - 確認待ち"
    MESSAGE="入力を待っています"
    SOUND="/System/Library/Sounds/Blow.aiff"
    ;;
  *)
    TITLE="Claude Code"
    MESSAGE="応答が完了しました"
    SOUND="/System/Library/Sounds/Glass.aiff"
    ;;
esac

# コンテキスト情報を追加
if [ -n "$REPO_NAME" ]; then
  MESSAGE="$MESSAGE ($REPO_NAME)"
elif [ -n "$TMUX_WINDOW" ]; then
  MESSAGE="$MESSAGE ($TMUX_WINDOW)"
fi

# terminal-notifier で通知を送信
if command -v terminal-notifier &> /dev/null; then
  echo "[$(date)] Sending notification: $MESSAGE" >> "$LOG_FILE"
  terminal-notifier -title "$TITLE" -message "$MESSAGE" 2>> "$LOG_FILE"

  if command -v afplay &> /dev/null; then
    afplay "$SOUND" &
    echo "[$(date)] Notification and sound sent successfully" >> "$LOG_FILE"
  else
    echo "[$(date)] Notification sent (no sound)" >> "$LOG_FILE"
  fi
  exit 0
fi

# フォールバック: システムサウンドを鳴らす
if command -v afplay &> /dev/null; then
  echo "[$(date)] Playing sound with afplay" >> "$LOG_FILE"
  afplay "$SOUND" &
  echo "[$(date)] Sound playback initiated" >> "$LOG_FILE"
  exit 0
fi

# 最終フォールバック: ビープ音
echo "[$(date)] Using beep as last resort" >> "$LOG_FILE"
printf '\a'
exit 0
