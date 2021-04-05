variable "region" {
  type    = string
}

variable "lambda_schedule_expression" {
  description = "Lambda schedule expression. Defaults to every 5 minutes"
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