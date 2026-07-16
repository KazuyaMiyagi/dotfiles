---
paths:
  - "**/*.sql"
---

# SQL 規約

## ファイル変更時のチェック

SQL ファイル（`.sql`）を変更した場合、コミット前に以下を実行する。

```bash
sqlfluff lint --dialect bigquery <file>
sqlfmt <file>
```

- `sqlfluff` の指摘（予約語の大文字小文字・インデント・末尾カンマなど）は修正してからコミットする。
  自動修正できるものは `sqlfluff fix --dialect bigquery <file>` で直す
- `sqlfmt` で整形差分が出たら整形してからコミットする
