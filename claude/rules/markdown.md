---
paths:
  - "**/*.md"
  - "**/*.markdown"
---

# Markdown 規約

## ファイル変更時のチェック

Markdown ファイル（`.md`/`.markdown`）を変更した場合、コミット前に以下を必ず実行してエラー・警告がないことを確認する。
いずれもエディタ保存時に efm-langserver 経由で走るリンターと同じツールなので、CLI の結果とエディタの指摘が一致する。

```bash
prettier --parser markdown --check <file>                            # 整形差分の確認
markdownlint-cli2 <file>                                              # 構文・スタイルの静的解析
textlint --config ~/.config/textlint/textlintrc --format compact <file>  # 日本語文章校正
```

- `prettier --parser markdown --check <file>` で差分が出たら
  `prettier --parser markdown --write <file>` で整形する。
  まず prettier で整形してから lint を確認する
- `markdownlint-cli2` の指摘（見出しレベルの飛び、リストのインデント、末尾空白など）は修正してからコミットする。
  自動修正できるものは `markdownlint-cli2 --fix <file>` で直す
- `textlint` の指摘（表記ゆれ、冗長表現、二重助詞など）も修正してからコミットする。
  自動修正できるものは `textlint --config ~/.config/textlint/textlintrc --fix <file>` で直す
- efm-langserver は引数の Markdown ファイルに対してこの 3 つを常に走らせる設定になっている。
  ルール／設定を変えるときは `efm-langserver/config.yaml` の該当ツールと
  `~/.config/textlint/textlintrc` を更新する。
  こうして CLI とエディタで挙動を揃える
