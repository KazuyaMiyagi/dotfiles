# グローバル Claude 設定

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

## Pull Request

- PR は必ずドラフトで作成すること（`gh pr create --draft`）
