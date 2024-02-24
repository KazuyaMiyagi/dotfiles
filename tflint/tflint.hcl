config {
  module = true
}

plugin "terraform" {
  enabled = true
  version = "0.5.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  preset = "all"
}

plugin "aws" {
  enabled = true
  version = "0.30.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = false
}

plugin "google" {
  enabled = true
  version = "0.27.1"
  source = "github.com/terraform-linters/tflint-ruleset-google"
  deep_check = false
}
