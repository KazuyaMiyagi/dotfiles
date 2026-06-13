---
paths:
  - "**/*.rb"
  - "**/*.rake"
  - "**/*.gemspec"
  - "**/Gemfile"
  - "**/Gemfile.lock"
  - "**/Rakefile"
---

# Ruby コーディング規約

## ファイル変更時のチェック

Ruby ファイル（`.rb` / `Gemfile` / `Rakefile` など）を変更した場合、コミット前に以下を実行する。

```bash
rubocop <path>      # lint + フォーマットチェック
```

- 指摘が出たら `rubocop -a <path>`（安全な自動修正）で直す。`-a` で消えない違反だけ手で修正する。意味が変わり得る修正まで一括で当てたいときのみ `rubocop -A` を使う
- `rubocop` は asdf の default gem（`asdf/default-gems-packages`）で導入されるため、プロジェクト側に bundler 経由の rubocop があればそちら（`bundle exec rubocop`）を優先する
- プロジェクトに `.rubocop.yml` がある場合はそれに従い、グローバル設定で上書きしない
