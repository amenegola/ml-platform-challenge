data "aws_iam_policy_document" "kinesis_firehose_stream_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "kinesis_firehose_stream_role" {
  name               = var.kinesis_firehose_stream_role_name
  assume_role_policy = data.aws_iam_policy_document.kinesis_firehose_stream_assume_role.json
}