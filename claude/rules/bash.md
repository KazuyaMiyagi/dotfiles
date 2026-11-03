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
- 条件式は `[ ]` ではなく `[[ ]]` で書く
- 変数は `${var}` と波括弧を付けて参照する。
  位置パラメータも `${1}`・`"${@}"`・`${#}` と書く
- 代入の右辺のコマンド置換も `x="$(command)"` とダブルクォートで囲む。
  算術式 `$((...))` は囲まない
- スクリプト内だけで使う補助の関数は `function __name()` と頭に `__` を付ける
- `usage` の中のコマンド名は `local COMMAND=...` と `readonly COMMAND` で宣言する
- 配列は `"${arr[@]}"` とダブルクォートで囲んで展開する
- ハイフン区切りはコマンド（ファイル名）だけに使い、関数名と変数名はアンダースコア区切りにする。
  コマンドと同じ処理をする関数も `send_text` のようにアンダースコアにする
- エラーは `echo "Error: ..." >&2` と書いて標準エラーに出す
- エスケープ文字は `\033` ではなく `\e` と書く
- `usage` は `cat <<- HEREDOC` で書き、本文をタブで字下げする
