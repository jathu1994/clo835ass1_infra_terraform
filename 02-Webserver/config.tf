terraform {
  backend "s3" {
    bucket = "clo835assignment1jatharthan"
    key    = "webserver/terraform.tfstate"
    region = "us-east-1"            
  }
}