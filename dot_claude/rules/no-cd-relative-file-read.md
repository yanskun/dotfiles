# cd してから相対パスでファイルを読まない

- `cd <dir> && grep/cat/find/rg/head/tail <相対パス>` のように、`cd` で移動してから
  相対パスでファイル読み取り系コマンドを実行しない。
- 理由: Claude Code の権限エンジンは、ファイル読み取り系 Bash コマンドが最終的に
  読む絶対パスを、`Read()` の allow/deny パターンとも突き合わせて評価している。
  `cd` を挟むと権限チェック時点(実行前の静的解析)で最終的な絶対パスが確定できず、
  `**/.env` 等の deny グロブに一致しないことを証明できないため、auto mode でも
  自動許可されず毎回確認を求められる。
- 対策1: ファイル読み取り系コマンドには常に絶対パスを直接渡す
  （例: `grep -rn "pattern" /abs/path/to/file`。
  `cd /abs/path && grep -rn "pattern" file` にはしない）。
  `git -C <dir> grep ...` のように絶対パスを明示できる形でも良い。
- 対策2: `cd $(git rev-parse --show-toplevel) && grep ...` のように cd 先がコマンド
  置換などでその場では絶対パス化できない場合は、`&&` で繋がず
  `cd $(git rev-parse --show-toplevel)` → 別の Bash 呼び出しで
  `grep -rn "pattern" <相対パス>` のように**2回に分割して実行**する
  （Bash ツールは呼び出し間で working directory が永続化されるため、2回目の
  呼び出し時点では cwd が実際に確定しており、権限チェックも解決できる）。
- `cd X && git add . && git commit -m "..."` のような、ファイル読み取りを伴わない
  一般的な `&&` 連結（書き込み・git 操作等）は対象外で、引き続き許容する。
