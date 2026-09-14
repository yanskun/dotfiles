# 作業計画

- [x] 既存の gcloud tab bar 表示スクリプトと Herdr 設定を確認する
- [x] account と project を 1 つの表示にまとめる挙動を RED で確認する
- [x] `herdr-gcloud-current-account` を account/project 表示に拡張する
- [x] account が取れない場合は project を取得せず、状態表示を 1 つだけ出す
- [x] fake `gcloud` で account/project/未ログイン/エラー/不在を検証する
- [x] `chezmoi diff` と `git diff` / `git status` を確認する
- [x] commit する

## レビュー

- `~/.local/bin/herdr-gcloud-current-account` の 1 コマンドで gcloud user と project をまとめて表示する。
- active user が取れた場合だけ `gcloud config get-value project` を実行し、` user / project` を表示する。
- active user が取れない場合は project を取りに行かず、` not logged in` または ` auth error` の 1 表示だけにする。
- project 未設定は ` user / no project`、project 取得失敗は ` user / project error` として表示する。
