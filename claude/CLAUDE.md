# グローバル AI エージェント設定

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

## Pull Request

- PR は必ずドラフトで作成すること（`gh pr create --draft`）
- Shared repository model（同一リポジトリのブランチから出す PR）の場合:
  - PR 本文は変更内容の説明（Summary / Test plan など）のみを記載し、「マージしてください」「ご確認お願いします」などのレビュアーへの依頼文は書かない
  - PR の作成者は自分自身であることを前提に、第三者にマージを依頼するような文体は使わず、作成者視点で客観的に書く
- Fork and pull model（フォークから upstream へ出す PR）の場合は、upstream のメンテナにマージを依頼する立場になるため、依頼文や背景説明を含めて構わない
