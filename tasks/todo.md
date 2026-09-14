# 作業計画

- [x] repo 固有ルールと既存 Herdr 設定を確認する
- [x] `prefix+d` の設定が Herdr config と稼働中 server に認識されるか確認する
- [x] `persiyanov.reviewr.toggle` が現在の Herdr / plugin action として有効か確認する
- [x] root cause に対する最小修正を行う
- [x] `herdr config check` と必要な runtime 確認で検証する
- [x] 差分と結果をレビュー欄に記録する

## レビュー

- 原因は Herdr 本体 config ではなく、reviewr plugin config の `base_branches`。reviewr `0.37.1` はこのキーを受け付けず、`prefix+d` 実行時に `unknown key "base_branches"` で toggle action が失敗していた。
- `dot_config/herdr/plugins/config/persiyanov.reviewr/config.toml` から `base_branches = ["develop", "main", "master"]` を削除した。
- `chezmoi apply --source /Users/naoyayasuda/.local/share/chezmoi /Users/naoyayasuda/.config/herdr/plugins/config/persiyanov.reviewr/config.toml` で実環境へ反映した。
- 検証: `HERDR_CONFIG_PATH=/Users/naoyayasuda/.local/share/chezmoi/dot_config/herdr/config.toml herdr config check` と `herdr config check` はどちらも `config: ok`。
- 検証: plugin root の `herdr-reviewr --resolve-plugin-config` は成功し、`default_scope`, `navigator_position`, `auto_open` を含む正規化済み config を返した。
- 検証: `herdr plugin action invoke toggle --plugin persiyanov.reviewr` は修正前 `plugin-log-1..23` で失敗、修正後 `plugin-log-24` 以降は `opened ...` / `closed ...` で成功。
