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

  name = var.kinesis_stream_name
  tags = var.kinesis_tags
}

module "kinesis-firehose-raw" {
  source                                = "../../modules/firehose"
  
  kinesis_firehose_stream_name          = var.kinesis_firehose_stream_name
  bucket_name                           = var.raw_bucket_name
  kinesis_stream_arn                    = module.kinesis_stream.kinesis_stream_arn
  kinesis_role_arn                      = module.kinesis_stream.kinesis_stream_iam_policy_read_only_arn
}