---
name: comment-audit
description: 既存または新規のコメントを SoT 規約 (CLAUDE.md / code-comments rule) に照らして audit し、削除・短縮候補を抽出する手順。「他に削れるコメントある?」「コメント減らしたい」「AI-workslop ないか?」のような問い、または PR/diff のレビュー段階で使う。
---

# Comment Audit

## 適用範囲
- 直前に書いた新規/修正コメント (uncommitted / staged)
- 現在の PR 差分
- 指定したファイルの全コメント

## 判定基準

| 残すべき | 削るべき |
|---|---|
| 非自明な局所的意図 (recipe quirk・stopPropagation の理由・副作用注意・workaround の根拠) | WHAT の言い換え (識別子で分かる事実の繰り返し) |
| 隠れた制約・契約・前提 | 現在のタスク言及 (「issue #X 用」「Y フローで追加」) — PR description が SoT |
| 触ろうとした人に必要な warning | rejected alternative (「X じゃなく Y にした」) — git blame が SoT |
|   | SoT ドキュメントの繰り返し (CLAUDE.md / rules / docs に既にある記述の再掲) |
|   | 下行で見える事実の言い直し (例: 「下記で override するので default は無視」) |

## 手順

1. **scope 確定**: 引数なし → `git diff` (uncommitted + staged) / 引数あり → そのファイル・PR 番号・コミット範囲。
2. **コメント抽出**: 行 (`//`) / ブロック (`/* */`) / JSX (`{/* */}`) / doc (`/** */`) を該当 scope から列挙。
3. **各コメントを評価**: 残す / 短縮 / 削除に分類。削除・短縮の理由は上記表の 1 語で示す (workslop / rejected-alt / restate / sot-dup)。
4. **提案を提示**: 削除/短縮候補のみリスト化 (「現在の文言」「提案 (削除 or 新文言)」「理由」)。残すコメントは「OK」とだけ言って長く解説しない (audit 出力自体が workslop 化しないため)。
5. **承認後に 1 commit で適用**: 動作変更を伴わないため typecheck/lint だけ確認。

## 注意
- 「全コメントを削れ」ではない。コメントは局所的意図の signal を残すためにある。
- 監査結果が「全部 keep」なら正直にそう言う (削減目標を機械的に立てない)。
- **書いた直後に一度通す**のが最も効果的 (PR レビューで指摘される前に)。
