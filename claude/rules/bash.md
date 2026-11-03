---
paths:
  - "**/*.sh"
  - "**/*.bash"
---

# Bash / シェルスクリプト規約

## ファイル変更時のチェック

シェルスクリプト（`.sh`/`.bash` や shebang が bash/sh のファイル）を変更した場合、コミット前に以下を実行する。

```bash
shellcheck <file>                             # 静的解析
shfmt -d -ln bash -i 4 -bn -ci -sr -kp <file> # 整形差分の確認
```

- `shellcheck` の指摘（未クォート変数 `SC2086`、`[ ]` vs `[[ ]]` など）は修正してからコミットする
- `shfmt -d` で差分が出たら `shfmt -w -ln bash -i 4 -bn -ci -sr -kp <file>` で整形する。
  efm-langserver の設定値は
  `--indent 4 --binary-next-line --case-indent --space-redirects --keep-padding`。
  フラグを揃えてあるので、エディタ保存時の整形と CLI の結果が一致する
- 変数は基本ダブルクォートで囲む。
  `set -e -u -o pipefail` を冒頭に置く。
  オプションを 1 つずつ書くと、`-o` が `pipefail` を引数に取ることが読み取りやすい
- shebang は `#!` とパスの間にスペースを入れて `#! /usr/bin/env bash` と書く
