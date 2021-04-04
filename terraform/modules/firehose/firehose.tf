data "aws_iam_policy_document" "kinesis_firehose_stream_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "kinesis_firehose_stream_role" {
  name               = var.kinesis_firehose_stream_role_name
  assume_role_policy = data.aws_iam_policy_document.kinesis_firehose_stream_assume_role.json
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  name        = var.kinesis_firehose_stream_name
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = var.kinesis_stream_arn
    role_arn           = var.kinesis_role_arn
  }
  
  s3_configuration {
    role_arn        = aws_iam_role.kinesis_firehose_stream_role.arn
    bucket_arn      = aws_s3_bucket.bucket.arn
    buffer_size     = var.buffer_size
    buffer_interval = var.buffer_interval
  }
}