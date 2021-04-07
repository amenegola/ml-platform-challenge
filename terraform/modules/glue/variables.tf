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

variable "crawler_schedule" {
  description = "Glue Crawler schedule as cron expression"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name where data is"
  type        = string
}