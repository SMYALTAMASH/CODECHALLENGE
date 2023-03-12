resource "aws_s3_bucket" "default" {
  bucket = "${var.name}"
  acl = "log-delivery-write"
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
