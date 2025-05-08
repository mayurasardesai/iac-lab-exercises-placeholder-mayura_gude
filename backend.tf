terraform {
  backend "s3" {
    bucket = "may-s3-tfstate"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"

    dynamodb_table = "may-dynamodb-tfstate-locks"
    encrypt        = true
  }
}