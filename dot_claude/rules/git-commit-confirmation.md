---
name: git-commit-confirmation
---

# git commit は必ず事前確認

- `git commit` する前に、必ずユーザーへ変更内容と差分を提示し、承認を得る。
- 「進めて」「やっちゃって」等の指示は、実装・`chezmoi apply` までの許可であって、
  commit までの許可ではない。commit は別途明示の承認を取る。
- push はさらに別途確認する。
