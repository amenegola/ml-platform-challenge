resource "aws_iam_role" "firehose_role" {
  name  = var.kinesis_firehose_stream_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "firehose-stream-policy" {
  name = var.kinesis_firehose_stream_name
  role = aws_iam_role.firehose_role.name

 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
       {
            "Effect": "Allow",
            "Action": "kinesis:*",
            "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
              "s3:AbortMultipartUpload",
              "s3:GetBucketLocation",
              "s3:GetObject",
              "s3:ListBucket",
              "s3:ListBucketMultipartUploads",
              "s3:PutObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}",
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
    ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  count = var.create_data_transformation == true ? 1 : 0

  name        = var.kinesis_firehose_stream_name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction",
                "lambda:GetFunctionConfiguration"
            ],
            "Resource": "${var.lambda_processor_arn}:$LATEST"
        }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "firehose_attach" {
  count = var.create_data_transformation == true ? 1 : 0

  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.policy[count.index].arn
}