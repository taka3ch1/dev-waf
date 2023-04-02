terraform {
  backend "s3" {
    bucket = "astcha-terraform-state"
    region = "ap-northeast-1"
    key = "terraform.tfstate"
  }
}