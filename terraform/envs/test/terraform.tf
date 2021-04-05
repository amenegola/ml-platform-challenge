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

module "trigger" {
  source                     = "../../modules/cloudwatch"

  cloudwatch_rule_name       = var.cloudwatch_rule_name
  lambda_arn                 = module.lambda_get_data.lambda_arn
  lambda_function_name       = var.lambda_get_data_name
  lambda_schedule_expression = var.lambda_schedule_expression
  create_kinesis_policy      = var.create_kinesis_policy
}

module "lambda_get_data" {
  source      = "../../modules/lambda"

  name        = var.lambda_get_data_name
  source_path = var.lambda_get_data_source_path
  handler     = var.lambda_get_data_handler
}

module "kinesis_stream" {
  source = "../../modules/kinesis"

  name   = var.kinesis_stream_name
  tags   = var.kinesis_tags
}

module "kinesis_firehose_raw" {
  source                            = "../../modules/firehose"
  
  kinesis_firehose_stream_name      = var.firehose_name_raw
  kinesis_firehose_stream_role_name = var.firehose_role_name_raw
  bucket_name                       = var.bucket_raw
  kinesis_stream_arn                = module.kinesis_stream.kinesis_stream_arn
}

module "lambda_clean_data" {
  source      = "../../modules/lambda"

  name        = var.lambda_clean_data_name
  source_path = var.lambda_clean_data_source_path
  handler     = var.lambda_clean_data_handler
}

module "kinesis_firehose_clean_data" {
  source                            = "../../modules/firehose"
  
  kinesis_firehose_stream_name      = var.firehose_name_clean
  kinesis_firehose_stream_role_name = var.firehose_role_name_clean
  bucket_name                       = var.bucket_clean
  kinesis_stream_arn                = module.kinesis_stream.kinesis_stream_arn
  create_data_transformation        = true
  lambda_processor_arn              = module.lambda_clean_data.lambda_arn
}
