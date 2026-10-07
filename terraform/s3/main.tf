terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "database_backup" {
  bucket = "${var.bucket_name}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Database Backups"
    Project     = "ProyectoBackendEvaluacion"
    Environment = "develop"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "database_backup" {
  bucket = aws_s3_bucket.database_backup.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}