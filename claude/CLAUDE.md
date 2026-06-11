# グローバル AI エージェント設定

## 実装方針（Red/Green/Refactor TDD）

コードの実装は、原則として Red/Green/Refactor の TDD サイクルで進める:

1. **Red**: まず失敗するテストを書き、実際にテストを実行して期待どおり失敗することを確認する
2. **Green**: テストを通すための最小限の実装を行い、テストが通ることを確認する
3. **Refactor**: テストが通る状態を保ったままコードを整理する

### ルール

- テストを書く前に実装を始めない
- 実装の都合に合わせてテストを歪めない（テストが仕様、実装が従う）
- 一度に書くテストは1つに絞り、小さく進める（仮実装 → 三角測量 → 明白な実装）
- Red フェーズの失敗を必ず確認してから実装に入る

### 適用の判断

- 「必ず TDD」ではなく、あくまでデフォルトの進め方とする
- 以下のようなケースでは TDD を省略してよい:
  - 自明・軽微な変更（typo 修正、設定値の変更など）
  - テストが馴染まない作業（ドキュメント、フォーマット、調査）
  - 既存テストの範囲で十分に守られているリファクタリング
- 省略する場合も、変更後にテストが通る状態は維持する

## Git コミットメッセージ

Conventional Commits 形式を使用すること:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### タイプ一覧

- `feat`: 新機能の追加
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマットなど）
- `refactor`: バグ修正でも新機能追加でもないコード変更
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
- コミット作成前に commitlint でメッセージを検証する:
  ```bash
  commitlint --config ~/.config/commitlint/config.mjs <<'EOF'
  <message>
  EOF
  ```

## Git コミット

- コミットは意味のある単位に分ける
- 各コミットはテストが通り、動作確認済みの状態にする

## Git ブランチ運用

- 作業は `main` から作業ブランチを切って行う。ブランチを切る前に `main` を最新化する:
  ```bash
  git switch main
  git pull
  git switch -c <branch>
  ```
- 作業ブランチはリモートに push する
- 作業終了時は、`main` に戻ってからローカルの作業ブランチを削除する:
  ```bash
  git switch main
  git branch -d <branch>
  ```

## Pull Request

- PR は必ずドラフトで作成すること（`gh pr create --draft`）
- Shared repository model（同一リポジトリのブランチから出す PR）の場合:
  - PR 本文は変更内容の説明（Summary / Test plan など）のみを記載し、「マージしてください」「ご確認お願いします」などのレビュアーへの依頼文は書かない
  - PR の作成者は自分自身であることを前提に、第三者にマージを依頼するような文体は使わず、作成者視点で客観的に書く
- Fork and pull model（フォークから upstream へ出す PR）の場合は、upstream のメンテナにマージを依頼する立場になるため、依頼文や背景説明を含めて構わない

### PR 作成済みのコミットを amend してフォースプッシュした場合

- コミット内容が変わったら、PR 本文も最新の変更内容に合わせて修正する
- 修正する際は、PR 本文が Web から編集されている可能性があるため、**必ず最新の本文を取得してから**書き換える:
  ```bash
  gh pr view --json body --jq .body   # 最新の本文を取得して内容を確認する
  gh pr edit --body "<更新後の本文>"
  ```

## Terraform

### ファイル変更時のリンティング

Terraform ファイル（`.tf`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
tf-linters 2>&1 | grep -v -e "INFO"
tf fmt --recursive
```

警告が出た場合は修正してからコミットする（未使用の data source、カンマ抜けなど）。
