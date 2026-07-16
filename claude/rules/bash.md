---
paths:
  - "**/*.sh"
  - "**/*.bash"
---

# Bash / シェルスクリプト規約

拡張子の無い shebang スクリプト（`#!/usr/bin/env bash` 等）はこの paths glob に一致しないので、その場合はこのルールを明示的に参照すること。

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
  `set -euo pipefail` を冒頭に置く
