terraform {
  backend "s3" {
    bucket         = "nav-store-tfstate"
    key            = "terraform/state"
    region         = "us-east-1"
  }
}
