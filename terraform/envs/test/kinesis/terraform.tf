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
  source = "../../../modules/kinesis"

  name                      = var.name
  shard_count               = var.shard_count
  retention_period          = var.retention_period
  shard_level_metrics       = var.shard_level_metrics
  enforce_consumer_deletion = var.enforce_consumer_deletion
  encryption_type           = var.encryption_type
  kms_key_id                = var.kms_key_id
  tags                      = var.tags
  create_policy_read_only   = var.create_policy_read_only
  create_policy_write_only  = var.create_policy_write_only
  create_policy_admin       = var.create_policy_admin
}