terraform {
  backend "s3" {
    bucket         = "okury-terraformbackend"
    key            = "dev/task2/terraform.tfstate"
  }
}