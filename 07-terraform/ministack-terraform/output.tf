output "arn" {
  description = "ARN of bucket"
  value = aws_s3_bucket.example.arn
}

output "name" {
  description = "name of bucket"
  value = aws_s3_bucket.example.bucket
}