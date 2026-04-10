---
name: tmux-watch
description: tmux の特定 pane を監視し、状態変化に応じて自律的に判断・行動するオーケストレータースキル。「tmux の X.Y と X.Z を見て」「tmux 監視して」のように使う。
allowed-tools: Bash(tmux capture-pane:*), Bash(tmux list-panes:*), Bash(tmux list-windows:*), Bash(tmux send-keys:*), Bash(bash $TMPDIR/tmux-capture*), Bash(sleep *), Agent, SendMessage, TaskOutput, TaskStop
---

# tmux-watch: tmux ペイン監視オーケストレーター

指定された tmux pane を 2 層構成で監視し、状態変化を検知して自律的に Next Action を判断する。

## Architecture

```
Layer 1: Capture (bash background)    — トークン消費ゼロ
  tmux capture-pane → diff → stdout(出力ファイル)

Layer 2: Orchestrator (background agent) — 判断時のみトークン消費
  出力ファイルを Read → 状態判定 → モードに応じた行動
```

## 引数パース

`$ARGUMENTS` から以下を抽出する。

### ペイン指定（必須、複数可）

| 形式 | 例 | 解釈 |
|------|-----|------|
| `W.P` | `2.0 3.1` | window=2 pane=0, window=3 pane=1 |
| `W:P` | `2:0 3:1` | 同上 |

### オプション

| 引数 | 説明 | デフォルト |
|------|------|-----------|
| `--mode MODE` | 自律度モード (`observe` / `suggest` / `auto`) | `suggest` |
| `--context TEXT` | ペインの役割説明（エージェントの判断精度向上） | なし |
| `--interval N` | キャプチャ間隔（秒） | `10` |
| `--lines N` | キャプチャ行数 | `50` |
| `--once` | 1回だけ全ペインをスナップショット | (継続監視) |

## 自律度モード（3段階）

| モード | 行動 |
|--------|------|
| `observe` | 状態変化を検知 → SendMessage で報告 + 推奨アクションを提示。**実行はしない** |
| `suggest` | 軽微なアクション（既知エラーの対処、コマンド再実行等）は自動実行。大きな判断はユーザーに確認 |
| `auto` | 検知した状態に応じて自分で判断・実行まで行う（tmux send-keys 含む）。報告は事後 |

## 実行手順

### Step 0: 引数が空の場合 — インタラクティブモード

`$ARGUMENTS` が空、またはペイン指定が含まれていない場合、対話的に設定を収集する。

1. まず現在の tmux ウィンドウとペインの一覧を取得する:

```bash
tmux list-windows -F '#{window_index}: #{window_name}'
tmux list-panes -a -F '#{window_index}.#{pane_index}: #{pane_current_command} (#{pane_width}x#{pane_height})'
```

2. `AskUserQuestion` で以下を順に聞く:

**Q1: 監視対象ペイン（上記一覧を選択肢に含める）**
- header: "対象ペイン"
- multiSelect: true
- options: 取得したペイン一覧から動的に生成（最大4つ。自分のペインは除外）
- 例: `0.1: claude (186x45)`, `0.2: zsh (93x45)`

**Q2: 自律度モード**
- header: "モード"
- options:
  - `observe` — 報告 + 提案のみ。実行はしない
  - `suggest (Recommended)` — 軽微なものは自動実行。大きな判断は確認
  - `auto` — フル自律。判断・実行まで行う

**Q3: コンテキスト（任意）**
- header: "コンテキスト"
- options:
  - `なし` — 特に補足情報なし
  - `入力する` — ペインの役割を自由記述

Q3 で「入力する」が選ばれた場合、ユーザーの Other 入力をコンテキストとして使用する。

収集した情報を使って Step 1 以降を実行する。

### Step 1: ペイン存在確認 + 初回スナップショット

指定された各ペインについて:

```bash
tmux list-panes -t {window} -F '#{pane_index} #{pane_current_command}'
```

存在しないペインがあればエラーを表示して終了。

全ペインの初回キャプチャを実行:

```bash
tmux capture-pane -t {window}.{pane} -p -S -{lines}
```

初回結果をユーザーに以下の形式で報告:

```
tmux-watch を開始します（モード: {mode}）

pane {W1}.{P1}: {現在のコマンド}
---
{キャプチャ内容の末尾10行}
---

pane {W2}.{P2}: {現在のコマンド}
---
{キャプチャ内容の末尾10行}
---

⚠ キャプチャ内容にシークレットが含まれる可能性があります。
```

`--once` の場合はここで終了。

### Step 2: Layer 1 — Background Capture Scripts

**ペインごとに** 以下のスクリプトを `$TMPDIR/tmux-capture-{window}-{pane}.sh` に書き出し、
`Bash(run_in_background: true)` で実行する。

```bash
#!/bin/bash
# tmux-capture for pane {window}.{pane}
TARGET="{window}.{pane}"
INTERVAL={interval}
LINES={lines}
PREV=""

for i in $(seq 1 360); do
  CURRENT=$(tmux capture-pane -t "$TARGET" -p -S "-$LINES" 2>&1)
  RC=$?

  if [ $RC -ne 0 ]; then
    echo "@@ERROR $(date '+%H:%M:%S') pane $TARGET not found or inaccessible"
    echo "$CURRENT"
    echo "@@END"
    exit 1
  fi

  if [ "$CURRENT" != "$PREV" ]; then
    echo "@@CHANGED $(date '+%H:%M:%S') iteration=$i"
    echo "$CURRENT"
    echo "@@END"
    PREV="$CURRENT"
  fi

  sleep "$INTERVAL"
done

echo "@@TIMEOUT $(date '+%H:%M:%S') max iterations reached"
```

各バックグラウンドタスクの **タスク ID** と **出力ファイルパス** を記録する。
これらは Layer 2 のエージェントに渡す。

### Step 3: Layer 2 — Orchestrator Agent

`Agent` ツールで以下のようにオーケストレーターを起動する:

```
Agent(
  name: "tmux-orchestrator",
  run_in_background: true,
  prompt: <下記のプロンプトテンプレート>
)
```

#### オーケストレーターへのプロンプト

以下の情報をすべて含めること:

```
あなたは tmux ペイン監視オーケストレーターです。
複数の tmux ペインの出力を監視し、状態変化に応じて行動してください。

## 監視対象

{ペインごとに以下を列挙}
- pane {W}.{P}: 出力ファイル={出力ファイルパス}, タスクID={タスクID}

## コンテキスト

{--context の内容。未指定なら「コンテキスト情報なし」}

## モード: {observe | suggest | auto}

{モードの説明を記載}

## 動作ルール

以下のループを繰り返してください:

1. 各ペインの出力ファイルの末尾100行を Read で確認する
2. @@CHANGED マーカーから最新の出力を抽出する
3. 以下の基準で状態を判定する:
   - エラー: スタックトレース、"error"、"Error"、"failed"、"FAIL"、
     "panic"、"exception"、compile error、permission denied、
     "command not found"、exit code 非ゼロ等
   - 完了: シェルプロンプト復帰（"$"、"❯"、">"で行が終わる）、
     Claude Code の入力待ち（">"プロンプト）
   - 待機中: Y/n 確認、"[y/N]"、"Press any key"、
     Claude Code の permission prompt、"Allow"/"Deny" 選択肢
   - 進行中: 出力が継続的に変化しているが上記に該当しない → 何もしない
4. 状態変化を検知したら、モードに応じて行動する:

### observe モード
- SendMessage で親エージェントに報告する
- フォーマット:
  tmux-orchestrator: pane {W}.{P}
  状態: {エラー | 完了 | 待機中}
  検知内容: {出力の要約3行以内}
  推奨アクション: {具体的な提案}

### suggest モード
- 以下は自動実行してよい:
  - 明らかなタイポや簡単なコマンドエラーの修正提案
  - テスト再実行の提案
  - 依存パッケージのインストール提案
- 以下は SendMessage でユーザーに確認:
  - アーキテクチャに関わる判断
  - ファイルの削除や大規模な変更
  - 不明瞭なエラーの対処

### auto モード
- 状態に応じて自分で判断し、tmux send-keys で対象ペインにコマンドを送信できる:
  tmux send-keys -t {W}.{P} '{command}' Enter
- 実行後、結果を SendMessage で事後報告する
- ただし破壊的操作（rm -rf、git push --force 等）は絶対に実行しない

5. Bash で `sleep 15` してから 1 に戻る
6. @@ERROR や @@TIMEOUT を検知したら、報告して終了する

## 重要な注意事項

- 進行中の状態では何もしない（過剰な報告は避ける）
- 同じ状態を繰り返し報告しない（前回と同じ状態なら skip）
- シークレット（API キー、パスワード、トークン）を検知したら内容を伏せて報告する
- 破壊的操作は auto モードでも絶対に実行しない
```

### ユーザーへの最終報告

Layer 1, 2 の起動が完了したら、以下をユーザーに報告:

```
tmux-watch オーケストレーター起動完了

監視対象:
- pane {W1}.{P1} (タスクID: {id1})
- pane {W2}.{P2} (タスクID: {id2})

モード: {mode}
間隔: {interval}秒

オーケストレーターがバックグラウンドで状態を監視します。
変化があれば自動的に報告されます。
```

## 注意事項

- tmux コマンドは sandbox 外で実行される（`excludedCommands` に設定済み）
- キャプチャ内容にシークレットが含まれる可能性があるため初回報告時に注記する
- Layer 1 (bash) はトークン消費ゼロ、Layer 2 (agent) は状態判定時のみトークン消費
- 最大監視時間は 1 時間（Layer 1 の 360 iterations × 10s）
- バックグラウンドタスクは `TaskStop` で停止可能
- オーケストレーターエージェントは `SendMessage(to: "tmux-orchestrator")` で追加指示可能
