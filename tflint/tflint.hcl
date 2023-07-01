config {
  module = true
}

plugin "terraform" {
  enabled = true
  version = "0.4.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  preset = "all"
}

plugin "aws" {
  enabled = true
  version = "0.24.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = true
}

plugin "google" {
  enabled = true
  version = "0.24.0"
  source = "github.com/terraform-linters/tflint-ruleset-google"
  deep_check = true
}
