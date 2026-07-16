# グローバル AI エージェント設定

## 応答スタイル

中身のない前置き・相槌・追従の枕詞を使わない。
回答は本題から始める。

具体的に避ける言い回しを以下に挙げる（これらに類するものも含む）。

```text
「鋭いご指摘です」「良いご指摘です」「いいご指摘です」
「いい質問です」「良い質問です」
「おっしゃる通りです」「まさにその通りです」「確かにそうですね」
「なるほど」「いいですね」「素晴らしいですね」
「ご質問ありがとうございます」「ご指摘ありがとうございます」
文末を過剰に和らげる「〜ですね！」のような共感の演出
```

ユーザーの意見への同意・称賛から入らず、必要なら結論や事実を直接述べる。

## 実装方針（Red/Green/Refactor TDD）

コードの実装は、原則として Red/Green/Refactor の TDD サイクルで進める。

1. **Red**: まず失敗するテストを書き、実際にテストを実行して期待どおり失敗することを確認する
2. **Green**: テストを通すための最小限の実装をして、テストが通ることを確認する
3. **Refactor**: テストが通る状態を保ったままコードを整理する

### ルール

- テストを書く前に実装を始めない
- 実装の都合に合わせてテストを歪めない（テストが仕様、実装が従う）
- 一度に書くテストは 1 つに絞り、小さく進める（仮実装 → 三角測量 → 明白な実装）
- Red フェーズの失敗を必ず確認してから実装に入る

### 適用の判断

- 「必ず TDD」ではなく、あくまでデフォルトの進め方とする
- 以下のようなケースでは TDD を省略してよい：
  - 自明・軽微な変更（typo 修正、設定値の変更など）
  - テストが馴染まない作業（ドキュメント、フォーマット、調査）
  - 既存テストの範囲で十分に守られているリファクタリング
- 省略する場合も、変更後にテストが通る状態は維持する

## Git コミットメッセージ

Conventional Commits 形式を使用する。

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### タイプ一覧

- `feat`: 新機能の追加
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマットなど）
- `refactor`: バグ修正・機能追加のいずれにも該当しないコード変更
- `perf`: パフォーマンスを改善するコード変更
- `test`: テストの追加・修正
- `build`: ビルドシステムや外部依存関係に影響する変更
- `ci`: CI 設定ファイルやスクリプトの変更
- `chore`: ソースやテストを変更しないその他の変更
- `revert`: 以前のコミットの取り消し

### ルール

- description は命令形で書く（"add" であって "added" や "adds" ではない）
- description の先頭は小文字にする
- description の末尾にピリオドをつけない
- description は 72 文字以内に収める
- subject と body の間には空行を入れる
- コミットメッセージに Issue や PR 番号を含めない
- コミット作成前に commitlint でメッセージを検証する：

  ```bash
  commitlint --config ~/.config/commitlint/config.mjs <<'HEREDOC'
  <message>
  HEREDOC
  ```

## Git コミット

- コミットは意味のある単位に分ける
- 各コミットはテストが通り、動作確認済みの状態にする

## Git ブランチ運用

- 作業は `main` から作業ブランチを切って行う。
  ブランチを切る前に `main` を最新化する：

  ```bash
  git switch main
  git pull
  git switch -c <branch>
  ```

- 作業ブランチはリモートに push する
- 作業終了時は、`main` に戻ってからローカルの作業ブランチを削除する：

  ```bash
  git switch main
  git branch -d <branch>
  ```

## Pull Request

- PR は必ずドラフトで作成すること（`gh pr create --draft`）
- Shared repository model（同一リポジトリのブランチから出す PR）の場合：
  - PR 本文は変更内容の説明（Summary/Test plan など）のみを記載し、「マージしてください」「ご確認お願いします」などのレビュアーへの依頼文は書かない
  - PR の作成者は自分自身であることを前提に、第三者にマージを依頼するような文体は使わず、作成者視点で客観的に書く
- Fork and pull model（フォークから upstream へ出す PR）の場合は、upstream のメンテナにマージを依頼する立場になるため、依頼文や背景説明を含めて構わない

### PR 作成済みのコミットを amend してフォースプッシュした場合

- コミット内容が変わったら、PR 本文も最新の変更内容に合わせて修正する
- 修正する際は、PR 本文が Web から編集されている可能性があるため、**必ず最新の本文を取得してから**書き換える：

  ```bash
  gh pr view --json body --jq .body   # 最新の本文を取得して内容を確認する
  gh pr edit --body "<更新後の本文>"
  ```

## 言語・ツール別ルール

言語/ツール固有のコーディング規約は `~/.claude/rules/` に分離してある。
`paths:` フロントマターでスコープし、該当ファイルを触ったときだけ読み込ませることで、無関係セッションの context を節約する。

- `rules/go.md` — Go（`gofmt`/`go vet`/`go test`、依存管理、テスト方針）
- `rules/ruby.md` — Ruby（`rubocop`）
- `rules/bash.md` — シェルスクリプト（`shellcheck`/`shfmt`）
- `rules/terraform.md` — Terraform（`tf-linters`/`terraform fmt`）
- `rules/github-actions.md` — GitHub Actions（`actionlint`）
- `rules/markdown.md` — Markdown（`prettier`/`markdownlint-cli2`/`textlint`）

これらは dotfiles の `claude/rules/*.md` を `~/.claude/rules/` へ
symlink している（`scripts/init` 参照）。
他のリポジトリやプラグインが提供する rules も同じ `~/.claude/rules/` に置けば共存する。

# Bash / シェルスクリプト規約

拡張子の無い shebang スクリプト（`#!/usr/bin/env bash` 等）はこの paths glob に一致しないので、その場合はこのルールを明示的に参照すること。

## ファイル変更時のチェック

シェルスクリプト（`.sh`/`.bash` や shebang が bash/sh のファイル）を変更した場合、コミット前に以下を実行する。

```bash
shellcheck <file>                             # 静的解析
shfmt -d -ln bash -i 4 -bn -ci -sr -kp <file> # 整形差分の確認
```

- `shellcheck` の指摘（未クォート変数 `SC2086`、`[ ]` vs `[[ ]]` など）は修正してからコミットする
- `shfmt -d` で差分が出たら `shfmt -w -ln bash -i 4 -bn -ci -sr -kp <file>` で整形する。
  efm-langserver の設定値は
  `--indent 4 --binary-next-line --case-indent --space-redirects --keep-padding`。
  フラグを揃えてあるので、エディタ保存時の整形と CLI の結果が一致する
- 変数は基本ダブルクォートで囲む。
  `set -euo pipefail` を冒頭に置く

# Go コーディング規約

## ファイル変更時のチェック

Go ファイル（`.go`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
gofmt -l .     # 未整形のファイル一覧（出力が空なら OK）
go vet ./...   # 静的解析
go build ./... # コンパイルが通ること
go test ./...  # テスト
```

- `gofmt -l .` に何か出たら `gofmt -w .`（または `go fmt ./...`）で整形してからコミットする。
  map リテラルへのキー追加などでアラインメントがずれやすいので、編集後は必ず確認する
- `go vet`/`go build`/`go test` はすべてグリーンの状態でコミットする
- `golangci-lint`/`staticcheck` が入っている環境では
  `golangci-lint run`（または `staticcheck ./...`）も併せて確認する

## 依存管理

- `import` を増減した、または `go.mod` を直接編集したら `go mod tidy` を実行し、`go.mod`/`go.sum` の差分も同じコミットに含める
- 標準ライブラリで済むものは外部依存を足さない。
  依存を追加する場合はメンテ状況・ライセンスを確認する

## コーディング規約

- Effective Go/Go Code Review Comments に従う。
  命名は短く Go 流（`ID`/`URL`/`HTTP` などの頭字語は全大文字、`getX` ではなく `X`）
- エクスポートする識別子には doc コメントを付け、**対象の名前で始める**（`// Foo は ...`）
- エラーは握りつぶさない。
  文脈を足すときは `fmt.Errorf("...: %w", err)` で wrap し、
  呼び出し側で `errors.Is`/`errors.As` 判定できるようにする
- ライブラリコードでは `panic` を使わず error を返す。
  `panic` は本当に回復不能なケースのみ
- 早期 return でネストを浅く保つ。
  `else` を減らす
- `context.Context` は第一引数で受け渡し、構造体に保持しない

## テスト方針

- 上位の「Red/Green/Refactor TDD」をデフォルトで適用する
- テーブルドリブンテストを基本とし、サブテストは `t.Run(name, ...)` で分ける
- hermetic に保つ： ファイル I/O は `t.TempDir()`、外部ネットワークに依存しない。
  フィクスチャは固定入力をコードで生成する
- 独立したテストには `t.Parallel()` を付ける
- 期待値と実際値のメッセージは `got`/`want` の語彙で書く

# Ruby コーディング規約

## ファイル変更時のチェック

Ruby ファイル（`.rb`/`Gemfile`/`Rakefile` など）を変更した場合、コミット前に以下を実行する。

```bash
rubocop <path>      # lint + フォーマットチェック
```

- 指摘が出たら `rubocop -a <path>`（安全な自動修正）で直す。
  `-a` で消えない違反だけ手で修正する。
  意味が変わり得る修正まで一括で当てたいときのみ `rubocop -A` を使う
- `rubocop` は asdf の default gem（`asdf/default-gems-packages`）で導入される。
  プロジェクト側に bundler 経由の rubocop があれば、そちら（`bundle exec rubocop`）を優先する
- プロジェクトに `.rubocop.yml` がある場合はそれに従い、グローバル設定で上書きしない

# Terraform 規約

## ファイル変更時のリンティング

Terraform ファイル（`.tf`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
tf-linters 2>&1 | grep -v -e "INFO"
terraform fmt -recursive
```

警告が出た場合は修正してからコミットする（未使用の data source、カンマ抜けなど）。

# GitHub Actions 規約

## ファイル変更時のリンティング

GitHub Actions 関連のファイルを変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。
対象には `.github/workflows/` 配下のワークフローや、
`.github/` 配下に置いた composite action の `action.yml` などが含まれる。

```bash
actionlint
```

引数なしの場合は `.github/workflows/` 配下のみ走査する。
`.github/workflows/` の外に置いたファイルはパスを明示して渡す。

```bash
actionlint .github/composite/<file>.yml
```

指摘が出たら修正してからコミットする（未定義の式、シェルスクリプトの不備、無効なイベント名、シェル `run` 内の `shellcheck` 指摘など）。

## アクションのバージョン固定

`uses:` で参照するアクションはコミット SHA でピン留めする。
GitHub Actions 関連のファイルを書いたら、必ず `pinact run -u` を実行し、各アクションを最新版のコミット SHA へ固定する。

```bash
pinact run -u
```

`-u` は参照先を最新版へ更新した上でピン留めする。
`uses: owner/repo@v1` のようなタグ参照や古い SHA が残っていないことを確認してからコミットする。

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
