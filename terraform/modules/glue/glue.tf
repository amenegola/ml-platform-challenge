resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.database_name
}

resource "aws_iam_role" "glue" {
  name = "AWSGlueServiceRoleDefault"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "glue_service" {
    role = aws_iam_role.glue.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy" "s3_policy" {
  name = "ms3_policy"
  role = aws_iam_role.glue.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
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

resource "aws_glue_crawler" "crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = var.crawler_name
  role          = aws_iam_role.glue.arn

  s3_target {
    path = "s3://${var.bucket_name}"
  }
}

