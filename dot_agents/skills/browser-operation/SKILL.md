---
name: browser-automation
description: agent-browser CLI で Web ページを開き、要素のクリック・フォーム入力・画面遷移などを自動操作する。「このページを開いて操作して」「フォームに入力して送信して」等で使う。コンソールやネットワークの調査が目的なら browser-debuging を使う。
allowed-tools: Bash(agent-browser:*)
---

Use `agent-browser` for web automation. Run `agent-browser --help` for all commands.

Core workflow:

1. `agent-browser open <url>` - Navigate to page
2. `agent-browser snapshot -i` - Get interactive elements with refs (@e1, @e2)
3. `agent-browser click @e1` / `fill @e2 "text"` - Interact using refs
4. Re-snapshot after page changes
