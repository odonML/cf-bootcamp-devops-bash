output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.website.arn
}

output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.website.bucket
}

output "website_endpoint" {
  description = "Endpoint del sitio web en AWS"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_url_aws" {
  description = "URL para AWS (no funciona en Ministack)"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "website_url" {
  description = "URL correcta del sitio web en Ministack/LocalStack"
  value       = "http://${aws_s3_bucket.website.id}.s3.localhost:4566"
  sensitive   = false
}

output "direct_access_url" {
  description = "URL de acceso directo al archivo index.html"
  value       = "http://${aws_s3_bucket.website.id}.s3.localhost:4566/index.html"
}
