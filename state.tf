terraform {
  backend "s3" {
    bucket = "hptldevops-state"
    key    = "tools/terraform.tfstate"
    region = "us-east-2"

  }
}
