---
paths:
  - "**/*.md"
  - "**/*.markdown"
---

# Markdown 規約

## ファイル変更時のチェック

Markdown ファイル（`.md`/`.markdown`）を変更した場合、コミット前に以下を必ず実行してエラー・警告がないことを確認する。

```bash
prettier --parser markdown --check <file>
markdownlint-cli2 --config ~/.config/markdownlint-cli2/config.jsonc <file>
textlint --config ~/.config/textlint/textlintrc --format compact <file>
```

- `prettier --parser markdown --check <file>` で差分が出たら
  `prettier --parser markdown --write <file>` で整形する。
  まず prettier で整形してから lint を確認する
- `markdownlint-cli2` の指摘（見出しレベルの飛び、リストのインデント、末尾空白など）は修正してからコミットする。
  自動修正できるものは `--fix` を付けて直す
- `textlint` の指摘（表記ゆれ、冗長表現、二重助詞など）も修正してからコミットする。
  自動修正できるものは `--fix` を付けて直す
