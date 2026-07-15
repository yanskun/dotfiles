#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Check Secure Input
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔒
# @raycast.packageName System

PID=$(ioreg -l -w 0 | grep -o '"kCGSSessionSecureInputPID"=[0-9]*' | cut -d= -f2)

if [ -z "$PID" ]; then
  echo "✅ Secure Input is OFF"
else
  # PIDからプロセス名を取得（パスを取り除いてファイル名のみ抽出）
  PROCESS_NAME=$(ps -p "$PID" -o comm= | awk -F/ '{print $NF}')
  echo "⚠️ Secure Input is ON: $PROCESS_NAME (PID: $PID)"
fi
