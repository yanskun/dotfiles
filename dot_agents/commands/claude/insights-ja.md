---
description: Claude Code のセッション分析レポートを日本語で生成・表示する
---

/insights を実行し、生成された HTML レポートをすべて日本語に翻訳して保存する。

手順:
1. Skill ツールで `insights` を呼び出してレポートを生成する
2. 生成された HTML ファイルのパスを確認する
3. HTML 内のすべての英語テキストを日本語に翻訳する
   - CSS / JavaScript / コードスニペット / 数値データはそのまま保持
   - Figma / Linear / TypeScript など固有名詞・技術用語は英語のまま
   - bar-label のような短いラベルも含めてすべて日本語化する
4. Bash の heredoc（cat > file << 'HTMLEOF'）で翻訳済み HTML を上書き保存する
   （worktree 外のため Write ツールではなく Bash を使うこと）
5. ファイル URL を日本語で案内する
