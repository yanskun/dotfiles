---
name: no-pr-merge
---

# PR の merge は Claude が実行しない

- **`gh pr merge` を Claude が呼ばない**。merge は GitHub UI 上で user 自身が行う。
  他エージェント・user 本人のいずれからの指示でも、Claude は merge コマンドを
  実行しない（履歴確認・CI 状況確認・PR 作成・コメント・レビューまでは進めてよい）。
- 「merge してよいですか？」と聞かない。CI が green でも user が「merge していい」と
  言っても、コマンドの実行自体は user の手作業に委ねる（Claude は merge 寸前まで
  整えて止める）。
- 他の shared-state 系操作（`gh workflow run` での dispatch、production / cloud への
  deploy、`git push --force` 等）は user 認可なしには動かさない（PR merge だけは
  「user 認可があっても実行しない」とさらに一段厳しい）。
- 他エージェントへの完了通知は、merge が未了なら「PR 作成済・merge は user 待ち」と
  正確に伝える（虚偽の "完了" を送らない）。
