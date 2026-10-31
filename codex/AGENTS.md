# グローバル AI エージェント設定

## 応答スタイル

中身のない前置き・相槌・追従の枕詞を使わない。
回答は本題から始める。

ユーザーの意見への同意・称賛から入らず、必要なら結論や事実を直接述べる。

Issue や PR は番号だけで呼ばず、タイトル（または内容の要約）で言及する。
番号は覚えられていないことが多く、「#123 は」と言われても何の話か分からない。
番号やリンクを添えるのは構わないが、主語にはタイトルを使う。

## 着手前の確認

Issue や仕様をもとに実装するときは、コードを書く前に次を洗い出してユーザーに示す。

- Issue の「未確定・要確認」などに挙がっている事項と、その解消状況
- Issue や仕様で決まっていないが、実装で決める必要があること（データの欠損や例外ケースの扱いなど）と、自分の推奨案
- Issue の指定とリポジトリの規約・慣例が食い違う箇所と、どちらに従うか

画面や他チームの実装に影響するものは、確認が取れてから実装する。
影響が実装内に閉じるものは推奨案で進めてよいが、PR 本文の「自分で決めた部分」に書く。

## 他のリポジトリを編集するとき

作業ディレクトリの外にあるリポジトリのファイルを編集するときは、編集する前に、そのリポジトリの指示ファイルを読んで従う。

- 対象は `AGENTS.md`・`CLAUDE.md` など。
  ルートから編集するファイルのディレクトリまでの各階層にあるものを読む
- シンボリックリンクを編集するときは、リンク先の実体を置いているリポジトリを対象にする
- 起動時に読み込まれるのは作業ディレクトリ側の指示だけなので、
  ほかのリポジトリの運用（コミット先のブランチ、push の可否など）は読まないと分からない

## 実装方針（Red/Green/Refactor TDD）

コードの実装は、原則として Red/Green/Refactor の TDD サイクルで進める。

1. Red では、まず失敗するテストを書き、実際にテストを実行して期待どおり失敗することを確認する
2. Green では、テストを通すための最小限の実装をして、テストが通ることを確認する
3. Refactor では、テストが通る状態を保ったままコードを整理する

### ルール

- 実装の都合に合わせてテストを歪めない（テストが仕様、実装が従う）
- 一度に書くテストは 1 つに絞り、小さく進める（仮実装 → 三角測量 → 明白な実装）

### 適用の判断

- 「必ず TDD」ではなく、あくまでデフォルトの進め方とする
- 以下のようなケースでは TDD を省略してよい：
  - 自明・軽微な変更（typo 修正、設定値の変更など）
  - テストが馴染まない作業（ドキュメント、フォーマット、調査）
  - 既存テストの範囲で十分に守られているリファクタリング
- 省略する場合も、変更後にテストが通る状態は維持する

## コードコメント

コメントに何を書くかは、コード・テストコード・コミットログとの役割分担で決める。

> コードには How
> テストコードには What
> コミットログには Why
> コードコメントには Why not
>
> を書こうという話をした
>
> — Takuto Wada, <https://x.com/t_wada/status/904916106153828352>

この考え方を採る。
コメントには Why not、つまり「なぜその方法を採らなかったのか」を書く。

- 自明なコメントは書かない（`# Integer` のように型や値をそのまま述べるだけのもの）
- コードをそのまま自然言語に置き換えただけの、翻訳でしかないコメントは書かない
- コードを読めば分かる分岐の説明（「〜の場合は nil」など）も、翻訳でしかないコメントとして書かない
- リポジトリのスキルや既存コードの例がこうしたコメントを付けていても、この方針を優先する

## 成果物は外向けの文章として書く

PR 本文・Issue 本文・コメント・コミットメッセージは、
そのリポジトリを見る人だけを読者として想定して書く。
チャットでのやり取りは成果物に持ち込まない。

### 書かないこと

- チャット上での検討過程、とくに実際には採らなかった案の比較
- 判断が変わった経緯や、指摘を受けて調べ直したという経過
- チャットで使った一般用語ではなく、そのコードベースで実際に使われている用語に合わせる

### 書くこと

- 判断の結果と、その根拠
- Issue や仕様で決まっていないことのうち、自分で決めた部分（レビューで判断を仰ぐため）

「Issue が決めていること」と「自分が決めたこと」を分けて書くと、
レビューアーがどこを見ればよいか判断しやすい。

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
- body には Why、つまり「なぜその変更が必要だったのか」を書く
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

## push 前の確認

- push する前に、push するコミットの差分とコミットメッセージをユーザーに見せて確認を取る
  - 「直して」「force push でいい」など修正や push の方法の指示を受けていても、push の直前に見せる
  - 確認が取れてから push する

## コミット履歴の書き換え

- レビュー依頼前（PR が未作成・draft・レビュー依頼前）は、確認を取らずに amend/rebase してよい
- レビュー依頼後は既存のコミットを書き換えない（amend・rebase・autosquash をしない）
  - 修正はコミットを足して、通常の push で反映する
- 依頼済みかどうかは、書き換える前に `gh pr view <PR> --json reviewRequests,reviews,labels` で確かめる

## 外部サービスへの投稿

- PR・Issue・Discussion へのコメントやレビュー、Slack などへの投稿は、ユーザーの明示的な指示なしに行わない
  - スキルの手順にコメント投稿が含まれていても、投稿の前に文面をユーザーに見せて確認を取る
  - URL だけが渡されたときは、何をするかを先に確認する。
    調査・レビューの結果はチャットで返し、投稿はしない

## クレデンシャル

- ファイルシステム上にある一時クレデンシャル（`~/.aws/sso/cache/`、`~/.aws/cli/cache/` など）は絶対に読まない

## Pull Request

- PR は必ずドラフトで作成すること（`gh pr create --draft`）
- Shared repository model（同一リポジトリのブランチから出す PR）の場合：
  - PR 本文は変更内容の説明（Summary/Test plan など）のみを記載し、「マージしてください」「ご確認お願いします」などのレビュアーへの依頼文は書かない
  - PR の作成者は自分自身であることを前提に、第三者にマージを依頼するような文体は使わず、作成者視点で客観的に書く
- Fork and pull model（フォークから upstream へ出す PR）の場合は、upstream のメンテナにマージを依頼する立場になるため、依頼文や背景説明を含めて構わない

### PR のコメントを読む

- PR をレビューするとき・PR の状況を答えるとき・レビューの指摘を直すときは、差分だけでなくコメントをすべて全文で読む
  - 対象はレビュースレッド（解決済み・outdated も含む）、会話コメント、レビュー本文
  - 本文を途中で切って読まない
  - 前に読んでいても、答える直前・直す直前に取り直す
- レビュースレッドは GraphQL の `reviewThreads` で取ると、解決状態と返信をまとめて読める：

  ```bash
  gh api graphql -F o=<owner> -F r=<repo> -F n=<PR> -f query='
    query($o: String!, $r: String!, $n: Int!) {
      repository(owner: $o, name: $r) {
        pullRequest(number: $n) {
          reviewThreads(first: 100) {
            nodes {
              isResolved isOutdated path line
              comments(first: 50) { nodes { author { login } body } }
            }
          }
          comments(first: 100) { nodes { author { login } body } }
          reviews(first: 100) { nodes { author { login } state body } }
        }
      }
    }'
  ```

### PR 作成済みのコミットを amend してフォースプッシュした場合

- コミット内容が変わったら、PR 本文も最新の変更内容に合わせて修正する
- 修正する際は、PR 本文が Web から編集されている可能性があるため、必ず最新の本文を取得してから書き換える：

  ```bash
  gh pr view --json body --jq .body   # 最新の本文を取得して内容を確認する
  gh pr edit --body "<更新後の本文>"
  ```

## Issue / PR の参照記法

PR 本文・Issue 本文・コメントで Issue や PR を参照するときは、
同一リポジトリかどうかにかかわらず、常に `owner/repo#123` 形式で書く。

```text
octo-org/octo-repo#123
```

- `#123` は「そのテキストが置かれたリポジトリ」の番号として解決される。
  別リポジトリのつもりで `#123` と書くと、同じ番号を持つ無関係な Issue へリンクされる
- `owner/repo#123` は同一リポジトリでもリンクとして機能するため、常にこの形式で書けば取り違えが起きない
- 完全な URL を貼ってもよい：`https://github.com/owner/repo/issues/123`
- `Closes` や `Fixes` などの自動クローズキーワードも同じ形式で書く。
  ただし別リポジトリの Issue はキーワードを書いても自動クローズされないため、単なる参照として扱う

## 言語・ツール別ルール

言語/ツール固有のコーディング規約を以下にまとめる。

## Bash / シェルスクリプト規約

### ファイル変更時のチェック

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

## Go コーディング規約

### ファイル変更時のチェック

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

### 依存管理

- `import` を増減した、または `go.mod` を直接編集したら `go mod tidy` を実行し、`go.mod`/`go.sum` の差分も同じコミットに含める
- 標準ライブラリで済むものは外部依存を足さない。
  依存を追加する場合はメンテ状況・ライセンスを確認する

### コーディング規約

- Effective Go/Go Code Review Comments に従う。
  命名は短く Go 流（`ID`/`URL`/`HTTP` などの頭字語は全大文字、`getX` ではなく `X`）
- エクスポートする識別子には doc コメントを付け、対象の名前で始める（`// Foo は ...`）
- エラーは握りつぶさない。
  文脈を足すときは `fmt.Errorf("...: %w", err)` で wrap し、
  呼び出し側で `errors.Is`/`errors.As` 判定できるようにする
- ライブラリコードでは `panic` を使わず error を返す。
  `panic` は本当に回復不能なケースのみ
- 早期 return でネストを浅く保つ。
  `else` を減らす
- `context.Context` は第一引数で受け渡し、構造体に保持しない

### テスト方針

- 上位の「Red/Green/Refactor TDD」をデフォルトで適用する
- テーブルドリブンテストを基本とし、サブテストは `t.Run(name, ...)` で分ける
- hermetic に保つ： ファイル I/O は `t.TempDir()`、外部ネットワークに依存しない。
  フィクスチャは固定入力をコードで生成する
- 独立したテストには `t.Parallel()` を付ける
- 期待値と実際値のメッセージは `got`/`want` の語彙で書く

## Ruby コーディング規約

### ファイル変更時のチェック

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

## Terraform 規約

### ファイル変更時のリンティング

Terraform ファイル（`.tf`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
tf-linters 2>&1 | grep -v -e "INFO"
terraform fmt -recursive
```

警告が出た場合は修正してからコミットする（未使用の data source、カンマ抜けなど）。

## GitHub Actions 規約

### ファイル変更時のリンティング

ワークフロー（`.github/workflows/` 配下）を変更した場合、コミット前に actionlint を実行してエラー・警告がないことを確認する。

```bash
actionlint
```

引数なしで `.github/workflows/` 配下を走査する。
actionlint はワークフロー専用のため、composite action の `action.yml` など
ワークフロー以外のファイルには実行しない（ワークフローとして解釈され誤検知になる）。

指摘が出たら修正してからコミットする（未定義の式、シェルスクリプトの不備、無効なイベント名、シェル `run` 内の `shellcheck` 指摘など）。

### アクションのバージョン固定

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

#### lockfile の対象外のもの

次のものは lockfile で固定されないので、`pinact run -u` でコミット SHA にピン留めする。

- reusable workflow の呼び出し（`jobs.<job_id>.uses`）
- composite action の `action.yml` 内の `uses:`。
  呼び出し側が lockfile を使うとは限らない

#### lockfile の扱い

- lockfile は手で編集しない。
  ワークフローを直して `gh actions-lock` で作り直す
- 同じリポジトリ内のアクションやワークフローは `./` ではなく `$/` で参照する。
  `./` だと呼び出し元の lockfile が適用されない
- lockfile の差分は依存の更新としてレビューする。
  `commit` の変化は実行されるコードの変化を意味する。
  `owner_id`・`repo_id` が変わっていたら、同じ名前が別のリポジトリを指しているので調べる

## Markdown 規約

### ファイル変更時のチェック

Markdown ファイル（`.md`/`.markdown`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
prettier --parser markdown --check <file>
markdownlint-cli2 --config ~/.config/markdownlint-cli2/config.jsonc <file>
textlint --config ~/.config/textlint/textlintrc --format compact <file>
```

- `prettier --parser markdown --check <file>` で差分が出たら
  `prettier --parser markdown --write <file>` で整形する。
  まず prettier で整形してから lint を確認する
- `markdownlint-cli2` の指摘（見出しレベルの飛び、リストのインデント、末尾空白など）は修正してからコミットする。
  自動修正できるものは `--fix` を付けて直す
- `textlint` の指摘（表記ゆれ、冗長表現、二重助詞など）も修正してからコミットする。
  自動修正できるものは `--fix` を付けて直す

## Vim script 規約

### ファイル変更時のチェック

Vim script（`.vim`/vimrc など）を変更した場合、コミット前に以下を実行する。

```bash
vint <file>
```

- `vint` の指摘（未定義変数・非推奨の記法・`set` の誤りなど）は修正してからコミットする

## Dockerfile 規約

### ファイル変更時のチェック

Dockerfile を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
hadolint <file>
docker build --check -f <file> .
trivy config <file>
```

- `hadolint` の指摘（バージョン固定漏れ・`ADD` と `COPY` の使い分けなど）は修正してからコミットする
- `docker build --check` は BuildKit のビルド前チェックで、非推奨構文や警告を検出する
- `trivy config` は設定ミスや既知の危険な記述を検出する

## SQL 規約

### ファイル変更時のチェック

SQL ファイル（`.sql`）を変更した場合、コミット前に以下を実行する。

```bash
sqlfluff lint --dialect bigquery <file>
sqlfmt <file>
```

- `sqlfluff` の指摘（予約語の大文字小文字・インデント・末尾カンマなど）は修正してからコミットする。
  自動修正できるものは `sqlfluff fix --dialect bigquery <file>` で直す
- `sqlfmt` で整形差分が出たら整形してからコミットする

## JSON 規約

### ファイル変更時のチェック

JSON ファイル（`.json`）を変更した場合、コミット前に以下を実行する。

```bash
prettier --check <file>
```

- 差分が出たら `prettier --write <file>` で整形してからコミットする
