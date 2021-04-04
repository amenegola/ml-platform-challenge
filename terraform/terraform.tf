terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

module "kinesis_stream" {
  source = "../../"

  name                      = var.name
  shard_count               = var.shard_count
  retention_period          = var.retention_period
  shard_level_metrics       = var.shard_level_metrics
  enforce_consumer_deletion = var.enforce_consumer_deletion
  encryption_type           = var.encryption_type
  kms_key_id                = var.kms_key_id
  tags                      = var.tags
  create_policy_read_only   = var.create_policy_read_only
  create_policy_write_only  = var.create_policy_write_only
  create_policy_admin       = var.create_policy_admin
}

resource "aws_s3_bucket" "raw_dev" {
  bucket = "random-beer-raw-${var.dev_prefix}"
  acl    = "private"
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_role-${var.dev_prefix}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "raw_stream" {
  name        = "registry-raw-data-${var.dev_prefix}"
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.dev.arn
    role_arn           = aws_iam_role.kinesis_role.arn
  }
  
  s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.raw_dev.arn
    buffer_size     = 1
    buffer_interval = 60
  }
}