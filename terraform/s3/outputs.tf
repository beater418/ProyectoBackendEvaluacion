output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.database_backup.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.database_backup.arn
}