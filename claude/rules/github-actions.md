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

GitHub Actions 関連のファイルを変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。対象には `.github/workflows/` 配下のワークフローや、`.github/` 配下に置いた composite action の `action.yml` などが含まれる。

```bash
actionlint
```

引数なしの場合は `.github/workflows/` 配下のみ走査する。`.github/workflows/` の外に置いたファイルはパスを明示して渡す。

```bash
actionlint .github/composite/<file>.yml
```

指摘が出たら修正してからコミットする（未定義の式、シェルスクリプトの不備、無効なイベント名、シェル `run` 内の `shellcheck` 指摘など）。

## アクションのバージョン固定

`uses:` で参照するアクションはコミット SHA でピン留めする。GitHub Actions 関連のファイルを書いたら、必ず `pinact run -u` を実行し、各アクションを最新版のコミット SHA へ固定する。

```bash
pinact run -u
```

`-u` は参照先を最新版へ更新した上でピン留めする。`uses: owner/repo@v1` のようなタグ参照や古い SHA が残っていないことを確認してからコミットする。
