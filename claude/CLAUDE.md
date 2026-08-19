# グローバル AI エージェント設定

## 応答スタイル

中身のない前置き・相槌・追従の枕詞を使わない。
回答は本題から始める。

ユーザーの意見への同意・称賛から入らず、必要なら結論や事実を直接述べる。

## 実装方針（Red/Green/Refactor TDD）

コードの実装は、原則として Red/Green/Refactor の TDD サイクルで進める。

1. **Red**: まず失敗するテストを書き、実際にテストを実行して期待どおり失敗することを確認する
2. **Green**: テストを通すための最小限の実装をして、テストが通ることを確認する
3. **Refactor**: テストが通る状態を保ったままコードを整理する

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
- Issue の記述と実装が食い違った点、後続タスクへの申し送り

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

## Issue / PR の参照記法

PR 本文・Issue 本文・コメントで Issue や PR を参照するときは、
同一リポジトリかどうかにかかわらず、常に `owner/repo#123` 形式で書く。

```text
readyfor/readyfor-issues#15333
```

- `#123` は「そのテキストが置かれたリポジトリ」の番号として解決される。
  別リポジトリのつもりで `#123` と書くと、同じ番号を持つ無関係な Issue へリンクされる
- `owner/repo#123` は同一リポジトリでもリンクとして機能するため、常にこの形式で書けば取り違えが起きない
- 完全な URL を貼ってもよい：`https://github.com/owner/repo/issues/123`
- `Closes` や `Fixes` などの自動クローズキーワードも同じ形式で書く。
  ただし別リポジトリの Issue はキーワードを書いても自動クローズされないため、単なる参照として扱う

## 言語・ツール別ルール

言語/ツール固有のコーディング規約は `~/.claude/rules/` に分離してある。
`paths:` フロントマターでスコープし、該当ファイルを触ったときだけ読み込ませることで、無関係セッションの context を節約する。

- `rules/go.md` — Go（`gofmt`/`go vet`/`go test`、依存管理、テスト方針）
- `rules/ruby.md` — Ruby（`rubocop`）
- `rules/bash.md` — シェルスクリプト（`shellcheck`/`shfmt`）。
  拡張子の無い shebang スクリプト（`bin/` 配下など）を触るときは明示的に読む
- `rules/terraform.md` — Terraform（`tf-linters`/`terraform fmt`）
- `rules/github-actions.md` — GitHub Actions（`actionlint`）
- `rules/markdown.md` — Markdown（`prettier`/`markdownlint-cli2`/`textlint`）
- `rules/vim.md` — Vim script（`vint`）
- `rules/dockerfile.md` — Dockerfile（`hadolint`/`docker build --check`/`trivy`）
- `rules/sql.md` — SQL（`sqlfluff`/`sqlfmt`）
- `rules/json.md` — JSON（`prettier`）

これらは dotfiles の `claude/rules/*.md` を `~/.claude/rules/` へ
symlink している（`scripts/init` 参照）。
他のリポジトリやプラグインが提供する rules も同じ `~/.claude/rules/` に置けば共存する。
