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

variable "kinesis_role_arn" {
  description = "Kinesis stream role arn"
  type        = string
}

variable "kinesis_firehose_stream_role_name" {
  description = "Kinesis stream role arn"
  type        = string
}

variable "buffer_size" {
  description = "Firehose buffer size"
  type        = number
}

variable "buffer_interval" {
  description = "Firehose buffer interval"
  type        = number
}