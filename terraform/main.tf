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

resource "aws_kinesis_stream" "dev" {
  name             = "random-beer-data-stream-${var.dev_prefix}"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags = {
    Environment = "development"
  }
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
    role_arn           = aws_iam_role.firehose_role.arn
  }
  
  s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.raw_dev.arn
    buffer_size     = 1
    buffer_interval = 60
  }
}