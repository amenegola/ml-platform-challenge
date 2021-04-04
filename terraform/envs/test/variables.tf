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