---
name: no-commit-design-docs
---

# 設計ドキュメントは git commit しない

- `docs/superpowers/specs/YYYY-MM-DD-*-design.md` 等の brainstorming 由来
  の設計ドキュメントは、ローカル参照用の作業ファイル扱い。**git に乗せない**
  （`git add` しない）。実装計画 (`docs/superpowers/plans/*`) も同様。
- superpowers の brainstorming skill / writing-plans skill のデフォルトは
  「設計 doc / plan を書いたら commit」だが、この指示は無視する。
  spec / plan ファイルはローカルに残してよい（user review 用）が commit しない。
- 知識は実装コード / `.claude/rules/` / `docs/`（mkdocs 等の SoT）に反映する。
  設計 doc は実装過程の参考資料であって、それ自体が SoT ではない。
