# このリポジトリでのブランチ運用（絶対ルール）

- **feature branch を切らずに `chezmoi` branch で作業する。**
- グローバル CLAUDE.md の「Always create a feature branch before making changes」
  はこのリポジトリには適用しない。本ルールが優先する。
- `git checkout -b` で新しいブランチを作らない。常に `chezmoi` branch 上で
  変更・コミットを行う。
