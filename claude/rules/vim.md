---
paths:
  - "**/*.vim"
  - "**/vimrc"
  - "**/.vimrc"
---

# Vim script 規約

## ファイル変更時のチェック

Vim script（`.vim`/vimrc など）を変更した場合、コミット前に以下を実行する。

```bash
vint <file>
```

- `vint` の指摘（未定義変数・非推奨の記法・`set` の誤りなど）は修正してからコミットする
