---
paths:
  - "**/*.json"
---

# JSON 規約

## ファイル変更時のチェック

JSON ファイル（`.json`）を変更した場合、コミット前に以下を実行する。

```bash
prettier --check <file>
```

- 差分が出たら `prettier --write <file>` で整形してからコミットする
