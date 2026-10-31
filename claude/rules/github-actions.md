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

ワークフロー（`.github/workflows/` 配下）を変更した場合、コミット前に actionlint を実行してエラー・警告がないことを確認する。

```bash
actionlint
```

引数なしで `.github/workflows/` 配下を走査する。
actionlint はワークフロー専用のため、composite action の `action.yml` など
ワークフロー以外のファイルには実行しない（ワークフローとして解釈され誤検知になる）。

指摘が出たら修正してからコミットする（未定義の式、シェルスクリプトの不備、無効なイベント名、シェル `run` 内の `shellcheck` 指摘など）。

## アクションのバージョン固定

ワークフローの step で使うアクションは、lockfile（`.github/workflows/actions.lock`）でコミット SHA に固定する。
lockfile の対象外になるものは、従来どおり `uses:` をコミット SHA でピン留めする。

GitHub Actions 関連のファイルを書いたら、必ず次の順に実行する。

```bash
gh actions-lock
pinact run -u
```

- `gh actions-lock` は step の `uses:` を解決し、コミット SHA を lockfile に記録する。
  あわせて `uses:` を `owner/repo@v1.2.3` のようなタグ参照に書き換える
- `pinact run -u` は lockfile で固定済みのアクションには触れず、それ以外を最新版のコミット SHA へピン留めする。
  lockfile に載っていないアクションがあると失敗するので、そのときは `gh actions-lock` をやり直す

### lockfile の対象外のもの

次のものは lockfile で固定されないので、`pinact run -u` でコミット SHA にピン留めする。

- reusable workflow の呼び出し（`jobs.<job_id>.uses`）
- composite action の `action.yml` 内の `uses:`。
  呼び出し側が lockfile を使うとは限らない

### lockfile の扱い

- lockfile は手で編集しない。
  ワークフローを直して `gh actions-lock` で作り直す
- 同じリポジトリ内のアクションやワークフローは `./` ではなく `$/` で参照する。
  `./` だと呼び出し元の lockfile が適用されない
- lockfile の差分は依存の更新としてレビューする。
  `commit` の変化は実行されるコードの変化を意味する。
  `owner_id`・`repo_id` が変わっていたら、同じ名前が別のリポジトリを指しているので調べる
