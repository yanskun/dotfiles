---
allowed-tools:
  - Bash(cat:*)
  - Bash(jq:*)
  - Bash(ls:*)
  - Bash(sort:*)
  - Bash(comm:*)
  - Bash(wc:*)
  - Bash(sed:*)
  - Bash(head:*)
  - Bash(tail:*)
  - Bash(awk:*)
  - Bash(grep:*)
  - Read
  - Glob
description: Skill と Agent の使用状況を分析し、死んでいる/効いていないものを特定する
---

ハーネス（Skill / Agent）の使用ログと定義を突き合わせて、何が呼ばれ何が呼ばれていないかをレポートする。

ログは hook 導入後から記録される（過去セッションは遡れない）。**この点をレポート冒頭に必ず明記すること。**

## 入力

- Skill ログ: `~/.claude/skill-usage.log`（PreToolUse(Skill) hook。`{ts, skill, session, cwd}` の JSONL）
- Agent ログ: `~/.claude/subagent-usage.log`（SubagentStop hook。`{ts, type, id, session}` の JSONL）
- 自前 Skill 定義: `~/.claude/skills/*/SKILL.md`（frontmatter の `name`）
- 自前 Agent 定義: `~/.claude/agents/*.md`（symlink 含む）

ログが存在しない場合は「まだログが無い」旨を伝え、そのセクションをスキップする。

## モード判定

`$ARGUMENTS` を見る。

- **セッション ID が渡された場合** → 「セッション診断モード」だけを実行する。
- **引数なし** → 「全体監査モード」を実行する。

## セッション診断モード（`$ARGUMENTS` にセッション ID）

両ログをそのセッション ID で絞り込み、発火した Skill / Agent を時系列で一覧する。
「あのセッションで特定の Skill（例: `superpowers:brainstorming`）が出たか？」を確認するための機能。

- `jq` で `select(.session == "<id>")` して時系列表示。
- 該当が無ければ「このセッションでは Skill/Agent の発火記録なし」と明示（＝呼ばれていなかったことの確定）。

## 全体監査モード（引数なし）

### Skill セクション
- **呼び出し頻度ランキング**: skill 別の呼び出し回数を降順。plugin 名前空間付き（`superpowers:*` 等）も含めて表示。
- **一度も呼ばれていない自前 Skill**: `~/.claude/skills/*/SKILL.md` の name 一覧と、ログに出てくる skill 名を突き合わせ、ログに無いものを列挙（plugin skill は対象外＝自前のみ）。死んでいる候補。
- **直近傾向**: 直近7日・30日の呼び出し数（データがあれば）。

### Agent セクション
- **呼び出し頻度ランキング**: agent (type) 別の呼び出し回数を降順。
- **未使用エージェント**: `~/.claude/agents/*.md` の名前一覧と突き合わせ、一度も呼ばれていないものを列挙。
- **直近傾向**: 直近7日・30日の呼び出し数（データがあれば）。

### 推奨アクション
- 一度も呼ばれていない自前 Skill / Agent → description の trigger が曖昧でないか見直す、または削除候補。
- 高頻度で呼ばれているもの → 重要、維持推奨。
- description が曖昧で誤呼び出し/未呼び出しリスクがありそうなもの → 改善候補（`empirical-prompt-tuning` skill での品質改善や `/learn` での更新につなげる）。

## 出力形式

見やすいテーブル形式で出力すること。最後に具体的なアクション提案をまとめる。
