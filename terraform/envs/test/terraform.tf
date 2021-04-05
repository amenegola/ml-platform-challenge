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
  source = "../../modules/kinesis"

  name   = var.kinesis_stream_name
  tags   = var.kinesis_tags
}

module "kinesis_firehose_raw" {
  source                            = "../../modules/firehose"
  
  kinesis_firehose_stream_name      = var.kinesis_firehose_stream_name
  kinesis_firehose_stream_role_name = var.kinesis_firehose_stream_role_name
  bucket_name                       = var.raw_bucket_name
  kinesis_stream_arn                = module.kinesis_stream.kinesis_stream_arn
}

module "lambda_get_data" {
  source      = "../../modules/lambda"

  name        = var.lambda_get_data_name
  source_path = var.lambda_get_data_source_path
  handler     = var.lambda_get_data_handler
}
