variable "region" {
  type    = string
}

variable "kinesis_stream_name" {
  type    = string
}

variable "kinesis_tags" {
  type    = map
}

variable "kinesis_firehose_stream_name" {
  description = "Name to be use on kinesis firehose stream"
  type        = string
}

variable "kinesis_firehose_stream_role_name" {
  description = "Kinesis firehose role arn"
  type        = string
}

variable "raw_bucket_name" {
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