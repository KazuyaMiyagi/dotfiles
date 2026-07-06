plugin "terraform" {
  enabled = true
  version = "0.15.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  preset = "all"
}

plugin "aws" {
  enabled = true
  version = "0.48.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = false
}

plugin "google" {
  enabled = true
  version = "0.39.0"
  source = "github.com/terraform-linters/tflint-ruleset-google"
  deep_check = false
}
