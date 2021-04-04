resource "aws_iam_role" "firehose_role" {
  name  = var.kinesis_firehose_stream_role_name

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

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
          "kinesis:DescribeStream",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords",
          "kinesis:ListShards"
      ],
      "Resource": "arn:aws:kinesis:us-east-2:741183806697:stream/random-beer-data-stream"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.policy.arn
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
    role_arn           = aws_iam_role.firehose_role.arn
  }
  
  s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.bucket.arn
    buffer_size     = var.buffer_size
    buffer_interval = var.buffer_interval
  }
}