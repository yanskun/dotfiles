---
name: git-commit-confirmation
---

# git commit は必ず事前確認

- `git commit` する前に、必ずユーザーへ変更内容と差分を提示し、承認を得る。
  ただし `/pr-create` skill 実行中の commit はこの規則の対象外（skill 起動が
  PR 作成までの一連の許可。SoT は `~/.agents/skills/pr-create/SKILL.md`）。
- 「進めて」「やっちゃって」等の指示は、実装・`chezmoi apply` までの許可であって、
  commit までの許可ではない。commit は別途明示の承認を取る。
- push はさらに別途確認する。
- 多タスクの自動進行（superpowers の subagent-driven-development など）でも
  各 commit を「一括承認可」と訊かない / 訊かれても受けない。
  task ごとに止まって diff と commit メッセージを提示し、個別承認を取る。
  一括承認はペアレビュアー（agmsg の Codex など）が commit ごとに見る機会を
  奪い、レビューが post-hoc になるため避ける。
