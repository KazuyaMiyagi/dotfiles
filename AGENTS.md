# dotfiles

## Git 運用

ローカルで作業する場合、グローバル設定のブランチ運用・Pull Request のルールは、このリポジトリでは適用しない。

- 作業ブランチは切らず、`main` に直接コミットする
- Pull Request は作らない
- push はしない

Copilot cloud agent など GitHub 上で動くエージェントは、Pull Request でしか成果を返せない。
そのため通常どおりブランチを切って Pull Request を作る。

## エージェント向け指示の同期

`codex/AGENTS.md` は、`claude/CLAUDE.md` と `claude/rules/*.md` を Codex 向けに 1 ファイルへまとめた写し。
Codex は `~/.codex/AGENTS.md` しか読まないため、内容を手で写している。

`claude/CLAUDE.md` または `claude/rules/*.md` を変更したら、同じコミットで `codex/AGENTS.md` の対応箇所も直す。

- `claude/rules/*.md` の内容は「言語・ツール別ルール」の節の後ろに置く
- 写すときは `paths:` のフロントマターを除き、見出しを 1 段下げる
