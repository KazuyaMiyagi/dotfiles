plugin "terraform" {
  enabled = true
  version = "0.13.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  preset = "all"
}

plugin "aws" {
  enabled = true
  version = "0.44.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = false
}

plugin "google" {
  enabled = true
  version = "0.37.1"
  source = "github.com/terraform-linters/tflint-ruleset-google"
  deep_check = false
}
