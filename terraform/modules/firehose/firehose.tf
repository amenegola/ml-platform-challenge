resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  count = var.create_data_transformation == false ? 1 : 0

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

resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  count = var.create_data_transformation == true ? 1 : 0

  name        = var.kinesis_firehose_stream_name
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = var.kinesis_stream_arn
    role_arn           = aws_iam_role.firehose_role.arn
  }
  
  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.bucket.arn
    buffer_size     = var.buffer_size
    buffer_interval = var.buffer_interval
    
    processing_configuration {
      enabled = "true"

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = "${var.lambda_processor_arn}:$LATEST"
        }

        parameters {
          parameter_name  = "BufferSizeInMBs"
          parameter_value = 1
        }
      }
    }
  }
}
