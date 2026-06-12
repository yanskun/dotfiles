# Agent 追加ルール

このリポジトリで Claude Code / Codex / Gemini の subagent を増やすときの配置場所。

## 共有 agent (Claude / Codex / Gemini で共通利用)

1. 実体: `dot_agents/agents/<name>.md`
2. Claude 側エイリアス: `dot_claude/agents/symlink_<name>.md`
   - 中身は `../../.agents/agents/<name>.md` の1行のみ

両方を同じコミットで追加すること。片方だけだと:
- 実体だけ → Claude Code から見えない
- symlink だけ → リンク先が存在せず壊れる

## Claude Code 専用 agent

`dot_claude/agents/<name>.md` に実体を直接置く。`dot_agents/` には置かない。

## Command / Skill

現状は `dot_claude/symlink_commands` / `dot_claude/symlink_skills` でディレクトリごと共有している。Claude 専用を作る必要が出たら、agent と同じパターン (実ディレクトリ化 + 個別 `symlink_<name>`) に切り替える。
