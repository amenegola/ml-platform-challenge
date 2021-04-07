variable "kinesis_firehose_stream_name" {
  description = "Name to be use on kinesis firehose stream"
  type        = string
}

variable "bucket_name" {
  description = "The bucket name"
  type        = string
}

variable "kinesis_stream_arn" {
  description = "Kinesis stream arn"
  type        = string
}

variable "kinesis_firehose_stream_role_name" {
  description = "Kinesis stream role arn"
  type        = string
}

variable "buffer_size" {
  description = "Firehose buffer size"
  type        = number
  default = 1
}

variable "buffer_interval" {
  description = "Firehose buffer interval"
  type        = number
  default = 60
}

variable "create_data_transformation" {
  description = "Switch to create a Firehose stream with data transformation function"
  type        = bool
  default = false
}

variable "lambda_processor_arn" {
  description = "ARN for the lambda data transformation function"
  type        = string
  default = ""
}
