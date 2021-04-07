variable "region" {
  type    = string
}

variable "cloudwatch_rule_name" {
  description = "Event rule name"
  type = string
}

variable "lambda_schedule_expression" {
  description = "Lambda schedule expression. Defaults to every 5 minutes"
  type = string
}

variable "environment_variables" {
  description = "Environment variables for lambda function"
  type        = map
}

variable "create_kinesis_policy" {
  description = "Create policy to enable lambda to publish at kinesis"
  type        = bool
}

variable "kinesis_stream_name" {
  type    = string
}

variable "kinesis_tags" {
  type    = map
}

variable "firehose_name_raw" {
  description = "Name to be use on kinesis firehose stream"
  type        = string
}

variable "firehose_role_name_raw" {
  description = "Kinesis firehose role arn"
  type        = string
}

variable "bucket_raw" {
  description = "The bucket name"
  type        = string
}

variable "firehose_name_clean" {
  description = "Name to be use on kinesis firehose stream"
  type        = string
}

variable "firehose_role_name_clean" {
  description = "Kinesis firehose role arn"
  type        = string
}

variable "bucket_clean" {
  description = "The bucket name"
  type        = string
}

variable "lambda_get_data_name" {
  description = "Function name"
  type        = string
}

variable "lambda_get_data_source_path" {
  description = "Path to function source code"
  type        = string
}

variable "lambda_get_data_handler" {
  description = "Handler for function call"
  type        = string
}

variable "lambda_clean_data_name" {
  description = "Function name"
  type        = string
}

variable "lambda_clean_data_source_path" {
  description = "Path to function source code"
  type        = string
}

variable "lambda_clean_data_handler" {
  description = "Handler for function call"
  type        = string
}

variable "database_name" {
  description = "Glue database name"
  type        = string
}

variable "table_name" {
  description = "Glue Table name"
  type        = string
}

variable "crawler_name" {
  description = "Glue Crawler name"
  type        = string
}