resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.database_name
}

resource "aws_glue_crawler" "crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = var.crawler_name
  role          = aws_iam_role.glue.arn
  schedule      = var.crawler_schedule

  s3_target {
    path = "s3://${var.bucket_name}"
  }

  configuration = <<EOF
{
  "Version":1.0,
  "Grouping": {
    "TableGroupingPolicy": "CombineCompatibleSchemas"
  }
}
EOF
}
}

