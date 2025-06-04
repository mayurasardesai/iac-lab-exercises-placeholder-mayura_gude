output "s3_bucket_arn" {
  description = "S3 Bucket ARN"
  value       = aws_s3_bucket.my_s3_bucket.arn
}