# 作業計画

- [x] 既存の Herdr 設定と gcloud / Spotify 用スクリプトを確認する
- [x] repo 固有のブランチ運用ルールを確認する
- [x] `gcloud` の現在アカウント表示用スクリプトを追加する
- [x] `dot_config/herdr/config.toml` の `tab_bar_right` に追加スクリプトを並べる
- [x] ログイン済み・未ログイン相当の挙動をシェル上で検証する
- [x] `git diff` と `git status` で差分を確認する

## レビュー

- `gcloud auth list --filter='status:ACTIVE' --format='value(account)'` で現在の認証アカウントを表示する。
- active な認証アカウントがある場合は gcloud アイコン付きでアカウントを表示する。
- active な認証アカウントがない場合は ` not logged in`、`gcloud` がない場合は ` unavailable`、`gcloud` が失敗した場合は ` auth error` を表示する。
- tab bar には Spotify 表示の直後、時刻表示の前に gcloud 表示を追加した。
