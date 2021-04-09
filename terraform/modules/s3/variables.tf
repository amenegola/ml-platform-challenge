variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

variable "acl" {
  description = "ACL bucket"
  type        = string
  default     = "private"
}