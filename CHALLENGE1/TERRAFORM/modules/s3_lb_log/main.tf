resource "aws_s3_bucket" "default" {
  bucket = "${var.name}"
  region = "${local.bucket_region}"
  acl = "private"
  logging {
    target_bucket = "${var.logging_target_bucket}"
    target_prefix = "logs/${var.name}/"
  }
  versioning {
    enabled = "${var.versioning_enabled}"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle_rule {
    enabled = "${var.lifecycle_rule_enabled}"
    prefix  = "${var.lifecycle_rule_prefix}"
    transition {
      days          = "${var.standard_ia_transition_days}"
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = "${var.glacier_transition_days}"
      storage_class = "GLACIER"
    }
    expiration {
      days = "${var.expiration_days}"
    }
    noncurrent_version_transition {
      days          = "${var.glacier_noncurrent_version_transition_days}"
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }
  }
  force_destroy = "${var.force_destroy}"
  tags = "${var.tags}"
}
resource "aws_s3_bucket_policy" "default" {
  bucket = "${aws_s3_bucket.default.id}"
  policy = "${data.aws_iam_policy_document.default.json}"
}
data "aws_iam_policy_document" "default" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_elb_service_account.default.arn}"]
    }
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${var.name}/*",
    ]
  }
}
data "aws_elb_service_account" "default" {}
data "aws_region" "current" {}
locals {
  bucket_region = "${var.region == "" ? data.aws_region.current.name : var.region}"
}
