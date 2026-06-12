---
name: harness-learning
description: セッションで得た学びを dotfiles ハーネス（Skill / Rule / Subagent）に恒久反映する方法論。「学んだことを焼き込みたい」「/learn」のときに使う。手順は Skill、原則は Rule、専門役割は Subagent に振り分け、共有レイヤー（dot_agents / .chezmoitemplates）優先で chezmoi ソースを編集し apply する。
---

# Harness Learning

セッションの学びを使い捨てにせず、dotfiles ハーネスへ恒久的に焼き込む。
学びを **Skill / Rule / Subagent** のどれかに分類し、**共有レイヤー優先**で chezmoi ソースに反映する。

## 前提: リポジトリ構造

chezmoi ソース = `~/.local/share/chezmoi`。ソースを編集し `chezmoi apply` で実体へ反映する。

| chezmoi ソース | 実体 / 役割 |
|---|---|
| `dot_agents/skills/<name>/SKILL.md` | `~/.agents/skills/`（`~/.claude/skills` は symlink） |
| `dot_agents/commands/claude/<name>.md` | `~/.agents/commands/claude/`（`~/.claude/commands` は symlink） |
| `dot_agents/agents/<name>.md` + `dot_claude/agents/symlink_<name>.md` | `~/.agents/agents/` + `~/.claude/agents/` |
| `.chezmoitemplates/AGENTS.md` | Claude / Codex / Gemini が include する共有テンプレ |
| `dot_claude/CLAUDE.md.tmpl` | `~/.claude/CLAUDE.md`（Claude 固有） |

## ステップ

### 1. 学び抽出
- 引数（`$ARGUMENTS`）があればヒントに、なければ会話文脈から今回の学びを1つ以上抽出・要約する。
- 対象は「次回以降の行動を変える、再利用可能な知見」のみ。その場限りの事実は除外する。

### 2. 分類
各学びを次の基準で振り分ける。引数で種類（skill / rule / subagent）が指定されていればそれに従う。

- **手順・ワークフロー**（「こういうタスクのときこう進める」）→ **Skill**
- **常時適用の原則・禁止・好み** → **Rule**
- **独立した専門役割・別コンテキストに委譲したい実行者** → **Subagent**

迷う場合は「Skill 案 / Rule 案」を理由付きで併記し、ユーザーに選ばせる。

### 3. 配置先決定（共有ファースト）

| 学びの性質 | 種類 | 配置先 |
|---|---|---|
| 全エージェント共通の原則 | Rule | `.chezmoitemplates/AGENTS.md` |
| Claude 固有の原則 | Rule | `dot_claude/CLAUDE.md.tmpl`（共有で足りないときだけ） |
| 作業中リポ固有の原則 | Rule | そのリポの `.claude/rules/<name>.md`（chezmoi 外） |
| 手順・ワークフロー | Skill | `dot_agents/skills/<name>/SKILL.md` |
| 専門役割・委譲実行者（共有） | Subagent | `dot_agents/agents/<name>.md` + `dot_claude/agents/symlink_<name>.md` |
| 同上・Claude 専用 | Subagent | `dot_claude/agents/<name>.md` |

**共有ファースト原則**: まず `dot_agents` / `.chezmoitemplates` に入れる。`dot_claude` 側へは Claude 固有の事情があるとき、または symlink 等の構造上必要なときだけ反映する。

既存の同種ファイルがあれば**更新**、なければ**新規作成**する。

### 4. 提案提示（承認ゲート）
「学び → 種類 → ファイル → 差分案」をまとめて提示し、ユーザーの承認を待つ。承認までソースを書き換えない。

### 5. 書き込み
- chezmoi ソースを編集する。
- Subagent を共有追加する場合は `.claude/rules/add-agents.md` に従い、実体（`dot_agents/agents/<name>.md`）と symlink（`dot_claude/agents/symlink_<name>.md`、中身は `../../.agents/agents/<name>.md` の1行）を必ずセットで作る。片方だけにしない。

### 6. 反映
- `chezmoi diff` を確認する。
- 今回の学び由来でない差分が含まれていたら、apply 前に必ずユーザーに確認する。
- 問題なければ `chezmoi apply` を実行する。
- テンプレ（`.chezmoitemplates/AGENTS.md` / `dot_claude/CLAUDE.md.tmpl`）を触った場合は `chezmoi cat ~/.claude/CLAUDE.md` でレンダリングエラーが無いことを確認する。

### 7. コミット（任意）
ユーザーが望めばコミットする。main 直コミットは禁止。フィーチャーブランチを切ること。
