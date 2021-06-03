resource "aws_lambda_function" "s3_uploader" {
  function_name = "s3Uploader"
  handler = "app.handler"
  role = aws_iam_role.lambda_exec.arn
  runtime = "nodejs12.x"
  filename = "getSignedURL/getSignedURL.zip"
  environment {
    variables = {
      UploadBucket = aws_s3_bucket.upload_bucket.id
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

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

resource "aws_iam_policy" "s3_write_policy" {
  name = "s3_write_policy"
  description = "Allows Lambda to write to S3"


  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
              "s3:PutObject",
              "s3:PutObjectAcl",
              "s3:PutLifecycleConfiguration"
        ],
        "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}