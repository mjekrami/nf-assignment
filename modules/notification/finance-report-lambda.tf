data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./modules/notification/finance_report/finance_report.py"
  output_path = "./outputs/finance_report.zip"
}
resource "aws_iam_role" "iam_for_report" {
  name = "iam-for-report"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_lambda_function" "finance_report_function" {
  filename         = "finance_report.zip"
  function_name    = "finance_report"
  role             = aws_iam_role.iam_for_report.arn
  handler          = "lambda_function.main"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.8"
  environment {
    variables = {
      RECIPIENTS         = var.recipients
      SOURCE_EMAIL       = var.source_email
      REPORT_GRANULARITY = upper(var.report_granularity)
    }
  }
}

resource "aws_iam_role_policy_attachment" "finance_report_attachment" {
  role       = aws_iam_role.iam_for_report.name
  policy_arn = "arn:aws:iam:policy/service-role/AWSLambdaBasicExecutionRole"
}
