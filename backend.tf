/*
terraform {
  backend "s3" {
    bucket         = "drax-dev-terraform-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
*/

