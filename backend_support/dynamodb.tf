resource "aws_dynamodb_table" "terraform_locks" {
  name         = "may-dynamodb-tfstate-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
