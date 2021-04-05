# codes for pip install and zip packaging
resource "null_resource" "pip" {
  triggers = {
    main         = base64sha256(file("${var.source_path}/main.py"))
    requirements = base64sha256(file("${var.source_path}/requirements.txt"))
    execute      = base64sha256(file("pip.sh"))
  }

  provisioner "local-exec" {
    command = "${var.source_path}/pip.sh ${var.source_path}/source"
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = "${var.source_path}/source.zip"

  depends_on = [null_resource.pip]
}

# codes for lambda functions
resource "aws_iam_role" "lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "source" {
  filename         = "${var.source_path}/source.zip"
  source_code_hash = data.archive_file.source.output_base64sha256
  function_name    = var.function_name
  role             = aws_iam_role.lambda.arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  publish          = var.publish

  environment {
    variables = {
      HASH = "${base64sha256(file("main.py"))}-${base64sha256(file("requirements.txt"))}"
    }
  }

  lifecycle {
    ignore_changes = ["source_code_hash", "last_modified"]
  }
}