variable "aws_region" {
  description = "Region AWS para el bucket de backups"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Bucket S3 para backups de la base de datos"
  type        = string
  default     = "bucket-codigo-backup"
}