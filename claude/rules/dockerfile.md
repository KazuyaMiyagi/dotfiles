---
paths:
  - "**/Dockerfile"
  - "**/Dockerfile.*"
  - "**/*.dockerfile"
---

# Dockerfile 規約

## ファイル変更時のチェック

Dockerfile を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
hadolint <file>
docker build --check -f <file> .
trivy config <file>
```

- `hadolint` の指摘（バージョン固定漏れ・`ADD` と `COPY` の使い分けなど）は修正してからコミットする
- `docker build --check` は BuildKit のビルド前チェックで、非推奨構文や警告を検出する
- `trivy config` は設定ミスや既知の危険な記述を検出する
