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
  source = "../../modules/kinesis"

  name = var.kinesis_stream_name
  tags = var.tags
}