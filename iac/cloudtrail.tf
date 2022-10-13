data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "trail_basic" {
  name                          = "cloudtrail_foobar"
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  s3_key_prefix                 = "trail_basic"
  include_global_service_events = false
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket        = "${data.aws_caller_identity.current.account_id}-cloudtrails"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "foo" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}"
        },
        {
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}/${aws_cloudtrail.trail_basic.s3_key_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}