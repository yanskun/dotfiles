---
name: herdr-agent-message
description: herdr で管理されている他の agent pane（別 worktree / 別タブで動く Claude Code や Codex 等）にメッセージを送り応答を確認する手順。作業を依頼して結果を受け取る場合も含む。「他の agent に FB して」「herdr 経由で伝えて」「並行作業中の agent に連絡して」「他の agent にレビューを頼んで」等で使う。
---

# herdr agent message

## いつ使うか

- 同じ herdr セッション内の別 pane で動いている agent（Claude Code / Codex 等）に、作業内容の共有・コンフリクト確認・FB を送りたいとき。
- 別 pane の agent に作業（レビュー・調査・修正等）を**依頼して結果を受け取りたい**とき。
- ユーザーが「herdr 経由で」「他の agent に伝えて」等と言ったとき。

## 引数

- `target`: 対象を絞り込む条件（複数指定可・自然文でも良い）。
  - cwd の部分一致（例: `worktree-mail-detail-merge`）
  - terminal_title の部分一致（例: `メール証憑`）
  - agent 種別（例: `claude` / `codex`。herdr が対応する agent 種別に応じる）
  - pane_id 直接指定（例: `wN:p1`）— 一意に特定済みならこれが最速で以降の絞り込みは不要
- `message`: 送信する本文（Markdown 可）

呼び出し例: `Skill({skill: "herdr-agent-message", args: "target=worktree-mail-detail-merge かつ codex message=\"...\""})` のように自然文で渡してよい。曖昧なら候補一覧を提示してユーザーに選ばせる。

## 自分の pane_id は `$HERDR_PANE_ID`

```bash
echo "$HERDR_PANE_ID"   # 例: w1:p5
```

- 送信先候補から自分を除外するときに使う（cwd や terminal_title からの推測より確実）。
- 返信が必要な依頼では、この値を**返信先として本文に埋め込む**（後述）。
- 空の場合は herdr 管理下のセッションではない。herdr 経由の送受信自体ができないのでユーザーに報告する。

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
- 自分自身を除外する: `pane_id != $HERDR_PANE_ID`。

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

## 返信が必要な依頼を送るとき

`herdr agent prompt` は**本文しか相手に渡らない**。送信元の pane_id は伝わらず、受け手からは通常のユーザー入力と区別がつかない。だから「終わったら返してね」とだけ書いても、受け手は返す先を知らないので返せない。返信が必要なら、返信先と返信手段を本文に明記する。

### 本文テンプレート

冒頭と末尾の両方に返信ブロックを置く（作業が長いと末尾だけの指示は流れる）。

```text
[herdr-request from=w1:p5 reply-required]

<依頼内容: 何を・どこで・どこまでやってほしいか>

---
[herdr-request from=w1:p5 reply-required]
完了したら以下のコマンドで報告を返してください（必須）:

    herdr agent prompt "w1:p5" "<報告本文>"

報告に含めるもの:
- 何をしたか（1〜3行の要約）
- 成果物の場所（ファイルパス / hunk セッション等）
- 未完了・着手不可の場合はその理由
```

- `from=` と `herdr agent prompt` の引数は、**`$HERDR_PANE_ID` を展開した実値**を書く。`$HERDR_PANE_ID` という文字列のまま送ると、相手のシェルでは相手自身の pane_id に解決されて自分に返信してしまう。
- `[herdr-request ...]` は受け手が依頼だと判別するための固定マーカー。形を変えない。
- 依頼内容には**絶対パス**を書く。受け手は別 worktree にいるので、`.` や相対パスは別の場所に解決される。
- 大量の成果物（レビュー全文など）をメッセージで返させない。共有状態（ファイル / hunk セッション）に置かせて、返信は要約に留める。

### 返信が来ないときの回収

受け手の協力に頼らない回収経路を必ず持っておく。

```bash
# 相手が落ち着くまで待つ（レビュー等は長いので timeout は長めに）
herdr agent prompt "<pane_id>" "<message>" --wait --until idle --timeout 600000

# 待ちきれない / 返信が来ない場合は端末出力を直接読む
herdr agent read "<pane_id>" --lines 200
```

- 成果物が共有状態（git worktree のファイル、hunk セッションのコメント等）にあるなら、**返信を待たずそこを直接見るのが最短**。返信は「終わったか」を知るためだけのもの。
- 無言で待ち続けない。回収できなければ状況をユーザーに報告する。

## 注意

- 同一 worktree（`cwd` が同じ）に複数の agent が並行して動いていることがある（例: 自分の作業 pane と、別タスクの実装 pane）。cwd だけでは自分自身も候補に入りうるので、`$HERDR_PANE_ID` で自分を除外すること。
- 相手が Codex 等の別ハーネスの場合、こちらの `.claude/rules/` は相手に効かない。返信させたいなら、必要な指示はすべてメッセージ本文に含める。
