---
name: chrome-devtools-debugging
description: chrome-devtools MCP で Web ページの DOM・コンソールエラー・ネットワーク通信を調べ、UI 不具合や API エラーの原因を特定する。「画面が崩れる原因を調べて」「コンソールエラーを見て」「API のレスポンスを確認して」等、ブラウザ内部の状態を見る必要があるデバッグで使う。ページ操作だけが目的なら browser-operation を使う。
allowed-tools: Bash(agent-browser:*)
---

Use the `chrome-devtools` MCP server for deep technical inspection. Unlike `agent-browser`, it reads the browser's internal state.

Core workflow:

1. `take_snapshot` - Read the page structure to find root causes of UI issues.
2. `get_console_logs` - Check for JavaScript errors or warnings that aren't visible on the UI.
3. `list_network_requests` / `get_network_request` - Inspect API calls, status codes, and payloads.
4. `evaluate_script` - Run JS in the page context to test fixes or extract data.

Combine with `agent-browser` when you need to navigate first, then debug the resulting state.
