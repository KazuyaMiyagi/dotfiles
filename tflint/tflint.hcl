plugin "terraform" {
  enabled = true
  version = "0.16.1"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  preset = "all"
}

plugin "aws" {
  enabled = true
  version = "0.50.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = false
}

plugin "google" {
  enabled = true
  version = "0.41.0"
  source = "github.com/terraform-linters/tflint-ruleset-google"
  deep_check = false
}
