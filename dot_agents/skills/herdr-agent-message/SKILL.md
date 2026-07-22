---
name: herdr-agent-message
description: herdr で管理されている他の agent pane（別 worktree / 別タブで動く Claude Code や Codex 等）にメッセージを送り応答を確認する手順。「他の agent に FB して」「herdr 経由で伝えて」「並行作業中の agent に連絡して」等で使う。
---

# herdr agent message

## いつ使うか

- 同じ herdr セッション内の別 pane で動いている agent（Claude Code / Codex 等）に、作業内容の共有・コンフリクト確認・FB を送りたいとき。
- ユーザーが「herdr 経由で」「他の agent に伝えて」等と言ったとき。

## 引数

- `target`: 対象を絞り込む条件（複数指定可・自然文でも良い）。
  - cwd の部分一致（例: `worktree-mail-detail-merge`）
  - terminal_title の部分一致（例: `メール証憑`）
  - agent 種別（例: `claude` / `codex`。herdr が対応する agent 種別に応じる）
  - pane_id 直接指定（例: `wN:p1`）— 一意に特定済みならこれが最速で以降の絞り込みは不要
- `message`: 送信する本文（Markdown 可）

呼び出し例: `Skill({skill: "herdr-agent-message", args: "target=worktree-mail-detail-merge かつ codex message=\"...\""})` のように自然文で渡してよい。曖昧なら候補一覧を提示してユーザーに選ばせる。

## 手順

### 1. 候補一覧を取得

```bash
herdr agent list | python3 -c "
import json,sys
d=json.load(sys.stdin)
for a in d['result']['agents']:
    print(a['agent_session']['value'], '|', a['pane_id'], '|', a['cwd'], '|', a['agent_status'], '|', a['terminal_title_stripped'])
"
```

### 2. target 条件で絞り込み

- cwd / terminal_title / agent 種別への部分一致でフィルタする。
- **複数マッチしたら送信せずユーザーに確認する**（推測で送らない）。
- 自分自身（今動いているセッション）を誤って対象にしないよう、自分の `cwd` / `agent_session.value` を候補から除外する。

### 3. 送信は pane_id を使う（UUID 直指定は not_found になりうる）

```bash
herdr agent prompt "<pane_id>" "<message>" --wait --timeout 15000
```

- `agent_session.value`（UUID）を target に直接使うと `agent_not_found` になることがある。**pane_id（`wN:p1` 形式）を使う**。
- `--wait` はタイムアウトすることがあるが、それ自体は送信失敗を意味しない（相手が長考中なだけ）。タイムアウトしたら次のステップで確認する。

### 4. 応答確認

```bash
herdr agent read "<pane_id>"
```

出力の末尾（送信したメッセージ以降）を見て相手の応答があるか確認する。無ければ相手が作業中の可能性があるのでユーザーに状況を報告し、必要なら後で再確認する。

### 5. 報告

誰に何を送り、どんな応答があったかをユーザーに簡潔に報告する。

## 注意

- 同一 worktree（`cwd` が同じ）に複数の agent が並行して動いていることがある（例: 自分の作業 pane と、別タスクの実装 pane）。cwd だけでは自分自身も候補に入りうるので、自分の pane_id / agent_session.value を除外すること。
