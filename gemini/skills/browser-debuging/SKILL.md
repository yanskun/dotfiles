---
name: Chrome DevTools Debugging
description: Webサイトの解析・デバッグ・ネットワーク監視に関する要件
---

Use `chrome-devtools` for deep technical inspection. Unlike `agent-browser`, this tool interacts with the browser's internal engine.

Core workflow:

1. `inspect_dom` - Analyze the HTML/CSS structure to find root causes of UI issues.
2. `get_console_logs` - Check for JavaScript errors or warnings that aren't visible on the UI.
3. `get_network_requests` - Monitor API calls, status codes, and payload data.
4. `evaluate_javascript` - Execute JS directly in the browser context to test fixes or extract data.

Combine with `agent-browser` when you need to navigate first, then debug the resulting state.
