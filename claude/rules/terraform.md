---
paths:
  - "**/*.tf"
  - "**/*.tfvars"
  - "**/*.tf.json"
---

# Terraform 規約

## ファイル変更時のリンティング

Terraform ファイル（`.tf`）を変更した場合、コミット前に以下を実行してエラー・警告がないことを確認する。

```bash
tf-linters 2>&1 | grep -v -e "INFO"
terraform fmt -recursive
```

警告が出た場合は修正してからコミットする（未使用の data source、カンマ抜けなど）。
