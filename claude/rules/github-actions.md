---
paths:
  - ".github/**/*.y{a,}ml"
  - "!.github/dependabot.y{a,}ml"
  - "!.github/FUNDING.y{a,}ml"
  - "!.github/release.y{a,}ml"
  - "!.github/ISSUE_TEMPLATE/*.y{a,}ml"
---

# GitHub Actions 規約

## ファイル変更時のリンティング

GitHub Actions 関連のファイル（`.github/workflows/` 配下のワークフロー、`.github/` 配下に置いた composite action の `action.yml` など）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
actionlint
```

引数なしの場合は `.github/workflows/` 配下のみ走査する。`.github/workflows/` の外に置いたファイルはパスを明示して渡す。

```bash
actionlint .github/composite/<file>.yml
```

指摘が出たら修正してからコミットする（未定義の式、シェルスクリプトの不備、無効なイベント名、シェル `run` 内の `shellcheck` 指摘など）。
