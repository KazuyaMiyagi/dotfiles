---
paths:
  - "**/*.go"
  - "**/go.mod"
  - "**/go.sum"
---

# Go コーディング規約

## ファイル変更時のチェック

Go ファイル（`.go`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
gofmt -l .     # 未整形のファイル一覧（出力が空なら OK）
go vet ./...   # 静的解析
go build ./... # コンパイルが通ること
go test ./...  # テスト
```

- `gofmt -l .` に何か出たら `gofmt -w .`（または `go fmt ./...`）で整形してからコミットする。map リテラルへのキー追加などでアラインメントがずれやすいので、編集後は必ず確認する
- `go vet` / `go build` / `go test` はすべてグリーンの状態でコミットする
- `golangci-lint` / `staticcheck` が入っている環境では `golangci-lint run`（または `staticcheck ./...`）も併せて確認する

## 依存管理

- `import` を増減した、または `go.mod` を直接編集したら `go mod tidy` を実行し、`go.mod` / `go.sum` の差分も同じコミットに含める
- 標準ライブラリで済むものは外部依存を足さない。依存を追加する場合はメンテ状況・ライセンスを確認する

## コーディング規約

- Effective Go / Go Code Review Comments に従う。命名は短く Go 流（`ID` / `URL` / `HTTP` などの頭字語は全大文字、`getX` ではなく `X`）
- エクスポートする識別子には doc コメントを付け、**対象の名前で始める**（`// Foo は ...`）
- エラーは握りつぶさない。文脈を足すときは `fmt.Errorf("...: %w", err)` で wrap し、呼び出し側で `errors.Is` / `errors.As` 判定できるようにする
- ライブラリコードでは `panic` を使わず error を返す。`panic` は本当に回復不能なケースのみ
- 早期 return でネストを浅く保つ。`else` を減らす
- `context.Context` は第一引数で受け渡し、構造体に保持しない

## テスト方針

- 上位の「Red/Green/Refactor TDD」をデフォルトで適用する
- テーブルドリブンテストを基本とし、サブテストは `t.Run(name, ...)` で分ける
- hermetic に保つ: ファイル I/O は `t.TempDir()`、外部ネットワークに依存しない。フィクスチャは固定入力をコードで生成する
- 独立したテストには `t.Parallel()` を付ける
- 期待値と実際値のメッセージは `got` / `want` の語彙で書く
