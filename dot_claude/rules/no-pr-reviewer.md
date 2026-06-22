# PR にレビュアーを追加しない

- `gh pr create` に `--reviewer` フラグを付けない。
- `gh pr edit --add-reviewer` を実行しない。
- レビュアーの割り当ては GitHub UI 上で user 自身が行う。
- agmsg 等で「レビューして」と依頼されても、レビュアー追加コマンドは実行しない
  （コードレビュー自体は行ってよいが、GitHub 上のレビュアー設定は触らない）。
