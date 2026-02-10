# Terminal & tmux Workflow Guidelines for Agent Teams

## tmux Window Organization

### Agent Teams の Window 管理ルール

Agent Teamsを実行する際は、以下のWindow構成を使用します：

- **親Window（元のWindow）**: チームリーダーのみが常駐
  - ユーザーとのインタラクション
  - タスクの割り当てと監視
  - 全体の進捗管理
  - Window名の例: `0:team-lead`

- **子Window（新規作成）**: 全チームメイトを展開
  - Agent Teams実行時に自動的に新しいWindowを作成
  - 全てのチームメイト（子エージェント）はこのWindow内にペインとして配置
  - 各チームメイトの出力・ログを個別ペインで表示
  - Window名の例: `1:team-agents`, `1:swarm-workers`

### Window 作成とチームメイト展開の流れ

```bash
# 1. 親（チームリーダー）は元のWindowで実行
#    Window 0: team-lead

# 2. Agent Teams起動時に新しいWindowを作成
tmux new-window -n "team-agents"

# 3. 新しいWindow内でチームメイトを展開（自動）
#    Window 1: team-agents
#      ├─ Pane 0: agent-researcher
#      ├─ Pane 1: agent-tester
#      └─ Pane 2: agent-reviewer
```

### Naming Conventions

- **親Window**: `0:team-lead` または `0:main`
- **子Window**: `1:team-{チーム名}` または `1:agents`
  - 例: `1:team-api-dev`, `1:team-review`, `1:agents`
- **ペインタイトル**: 各チームメイトのClaude Code Session名を表示
  - 例: `researcher`, `tester`, `reviewer`

### Pane Title の設定

チームメイトの名前をペインの枠に表示することで、視認性が大幅に向上します。

#### tmux 初期設定（一度だけ実行）

```bash
# ペインボーダーにタイトルを表示（上部に表示）
tmux set -g pane-border-status top

# タイトルの表示形式を設定
tmux set -g pane-border-format " #{pane_title} "

# ボーダーの色を設定（オプション）
tmux set -g pane-border-style fg=colour240
tmux set -g pane-active-border-style fg=colour33
```

**永続化**: これらの設定を `~/.tmux.conf` に追加すると、次回起動時から自動適用されます。

```bash
# ~/.tmux.conf に追加
cat >> ~/.tmux.conf << 'EOF'

# Agent Teams用: ペインタイトルを表示
set -g pane-border-status top
set -g pane-border-format " #{pane_title} "
set -g pane-border-style fg=colour240
set -g pane-active-border-style fg=colour33
EOF
```

#### チームメイトspawn時のタイトル設定

各チームメイトをspawnした後、そのペインに名前を設定します：

```bash
# 新しいペインを作成してチームメイトをspawn
tmux split-window -h

# 作成したペインにタイトルを設定
tmux select-pane -T "researcher"

# 次のチームメイト
tmux split-window -v
tmux select-pane -T "tester"
```

**自動化例**（チームメイトを一括でspawn）:

```bash
#!/bin/bash
# Agent Teams用のWindow/Pane自動セットアップスクリプト例

# 1. 新しいWindowを作成
tmux new-window -n "team-agents"

# 2. 最初のペイン（チームメイト1）
tmux select-pane -T "researcher"
# ここでClaude Codeのチームメイトをspawn

# 3. 水平分割してチームメイト2
tmux split-window -h
tmux select-pane -T "tester"
# ここでClaude Codeのチームメイトをspawn

# 4. 左ペインを選択して垂直分割（チームメイト3）
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -T "reviewer"
# ここでClaude Codeのチームメイトをspawn

# 5. 右ペインを選択して垂直分割（チームメイト4）
tmux select-pane -t 2
tmux split-window -v
tmux select-pane -T "security-checker"
# ここでClaude Codeのチームメイトをspawn
```

#### ペインタイトルの変更

チームメイトの役割が変わった場合や、より詳細な情報を表示したい場合：

```bash
# 現在のペインのタイトルを変更
tmux select-pane -T "researcher-api"

# 特定のペイン番号を指定してタイトルを変更
tmux select-pane -t 0 -T "researcher"
tmux select-pane -t 1 -T "tester"
tmux select-pane -t 2 -T "reviewer"
```

#### 高度な表示形式

より詳細な情報を表示したい場合は、`pane-border-format` をカスタマイズ：

```bash
# タイトル + ペイン番号
tmux set -g pane-border-format " #{pane_title} [#{pane_index}] "

# タイトル + サイズ情報
tmux set -g pane-border-format " #{pane_title} (#{pane_width}x#{pane_height}) "

# タイトル + アクティブ状態
tmux set -g pane-border-format " #{?pane_active,🟢 ,⚪️ }#{pane_title} "
```

#### タイトル表示の確認

```bash
# 全ペインのタイトルを確認
tmux list-panes -F "#{pane_index}: #{pane_title}"

# 出力例:
# 0: researcher
# 1: tester
# 2: reviewer
# 3: security-checker
```

## Pane Layout Rules

チームメイト用のペイン分割ルール：

### 基本原則

- **水平分割（左右）**: 関連するタスクを持つチームメイト同士
  - 例: API開発担当（左）+ テスト担当（右）
  - 例: フロントエンド担当（左）+ バックエンド担当（右）

- **垂直分割（上下）**: 監視・ログの階層化
  - 例: メインタスク担当（上）+ ログ監視担当（下）
  - 例: 実行担当（上）+ レビュー担当（下）

- **最大ペイン数**: 1Windowにつき4ペインまで
  - それ以上のチームメイトが必要な場合は、さらに新しいWindowを作成
  - 認知負荷と視認性のバランスを保つ

### ペイン分割の推奨パターン

#### 2チームメイトの場合
- 水平分割（左右）または垂直分割（上下）どちらでも可
- 役割に応じて選択

#### 3チームメイトの場合
- メインペインを大きく取り、残り2つを分割
- 例: メイン実行担当（左大）+ 監視2名（右上・右下）

#### 4チームメイトの場合
- 2x2のグリッド配置
- 各象限に1チームメイトを配置

## Agent Teams での tmux 運用ルール

### Window/Pane の作成と管理

1. **Agent Teams起動前**
   ```bash
   # 現在のWindowを確認（親Windowとして維持）
   tmux list-windows
   ```

2. **Agent Teams起動時**
   ```bash
   # ペインタイトル表示を有効化（初回のみ）
   tmux set -g pane-border-status top
   tmux set -g pane-border-format " #{pane_title} "

   # 新しいWindowを作成（チームメイト用）
   tmux new-window -n "team-agents"

   # TeamCreateとチームメイトのspawn
   # （Claude Codeが自動的に新Window内で展開）
   ```

3. **チームメイト展開後**
   - 各チームメイトの出力が個別ペインに表示される
   - **各ペインにチームメイト名を設定**:
     ```bash
     # 現在のペインにタイトルを設定
     tmux select-pane -T "researcher"

     # または、ペイン番号を指定して設定
     tmux select-pane -t 0 -T "researcher"
     tmux select-pane -t 1 -T "tester"
     tmux select-pane -t 2 -T "reviewer"
     ```
   - ペイン間の移動: `Ctrl+b` + 矢印キー
   - 特定ペインへのフォーカス: `Ctrl+b` + `q` → 番号入力

### 並行作業時の注意

- **ペインサイズの調整**
  - 出力が多いチームメイトのペインを大きく
  - `Ctrl+b` + `:` → `resize-pane -D 10` (下に拡大)
  - `Ctrl+b` + `:` → `resize-pane -R 20` (右に拡大)

- **ペインのスクロール**
  - `Ctrl+b` + `[` でスクロールモード開始
  - 矢印キーまたは `PageUp/PageDown` でスクロール
  - `q` でスクロールモード終了

- **作業完了後**
  - チームメイトのシャットダウン後、不要なペインを閉じる
  - `Ctrl+b` + `x` → `y` で確認して削除

## 推奨レイアウト例

以下のレイアウト例では、ペイン上部にチームメイト名がタイトルとして表示されます。

### パターン1: 2チームメイト（水平分割）

```
┌─ researcher ────┬─ tester ────────┐
│                 │                 │
│ Task output:    │ Test output:    │
│ > Reading API   │ > Running tests │
│ > Analyzing...  │ > 15/20 passed  │
│                 │                 │
│ [Active]        │ [Active]        │
│                 │                 │
└─────────────────┴─────────────────┘
```

### パターン2: 3チームメイト（メイン + 2サブ）

```
┌─ researcher ─────────┬─ tester ─┐
│                      │          │
│ Task: API analysis   │ Running  │
│ Status: In progress  │ tests... │
│ Files: 15/30         │          │
│                      ├─ reviewer┤
│                      │          │
│                      │ Waiting  │
│                      │ for code │
└──────────────────────┴──────────┘
```

### パターン3: 4チームメイト（2x2グリッド）

```
┌─ frontend ───┬─ backend ────┐
│              │              │
│ Building UI  │ API impl.    │
│ components   │ in progress  │
│              │              │
├─ tester ─────┼─ reviewer ───┤
│              │              │
│ Writing E2E  │ Code review  │
│ test specs   │ checklist    │
│              │              │
└──────────────┴──────────────┘
```

### パターン4: 5+ チームメイト（複数Window）

チームメイトが5名以上の場合は、さらに新しいWindowを作成：

```
Window 0: team-lead          (親)
Window 1: team-agents-1      (チームメイト1-4)
Window 2: team-agents-2      (チームメイト5-8)
```

## Window/Pane 間の移動

### Window間の移動
- `Ctrl+b` + `n`: 次のWindowへ
- `Ctrl+b` + `p`: 前のWindowへ
- `Ctrl+b` + `0-9`: 指定番号のWindowへ
- `Ctrl+b` + `w`: Windowリストから選択

### Pane間の移動
- `Ctrl+b` + `↑↓←→`: 矢印キーで移動
- `Ctrl+b` + `q`: ペイン番号を表示して移動
- `Ctrl+b` + `o`: 次のペインへ循環移動

## トラブルシューティング

### ペインが小さすぎて出力が見づらい場合
```bash
# 下方向に10行拡大
Ctrl+b + : → resize-pane -D 10

# 右方向に20列拡大
Ctrl+b + : → resize-pane -R 20

# ペインを最大化/復元（トグル）
Ctrl+b + z
```

### チームメイトの出力が止まっている場合
```bash
# スクロールモードに入っていないか確認
# もし黄色いインジケータがあれば 'q' で終了

# ペインが "frozen" 状態でないか確認
Ctrl+b + : → select-pane -P 'bg=default'
```

### Window/Paneが多すぎて管理が困難な場合
```bash
# 不要なペインを閉じる
Ctrl+b + x

# 不要なWindowを閉じる
Ctrl+b + & → y

# 全Windowを確認
tmux list-windows
```

### チームメイトの出力ログを保存したい場合
```bash
# ペインの履歴をファイルに保存
Ctrl+b + : → pipe-pane -o 'cat >> ~/agent-output.log'

# ログ記録を停止
Ctrl+b + : → pipe-pane
```

## ベストプラクティス

1. **Window命名は必須**
   - 親Window: `0:team-lead`
   - 子Window: `1:team-{purpose}`
   - 後から見て分かる名前をつける

2. **ペイン数は4以下を維持**
   - 5名以上のチームメイトは複数Windowに分割
   - 視認性と管理のしやすさを優先

3. **作業完了後はクリーンアップ**
   - チームメイトシャットダウン後は不要なペインを削除
   - Window名を元に戻す（必要に応じて）

4. **ログは適宜保存**
   - 重要な出力は `pipe-pane` でファイル保存
   - デバッグや振り返りに活用
