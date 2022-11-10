resource "aws_s3_bucket" "lab1" {
  bucket = "orchsky-terraform"
}

resource "aws_s3_bucket" "lab1-replica" {
  bucket = "orchsky-replica"
}

resource "aws_s3_bucket_versioning" "lab1-replica-versioning" {
  bucket = aws_s3_bucket.lab1-replica.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "lab1-versioning" {
  bucket = aws_s3_bucket.lab1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lab1-lifecycle" {
  bucket = aws_s3_bucket.lab1.id
  rule {
    id = "rule1"
    expiration {
      days = 100
    }
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    transition {
      days          = 60
      storage_class = "ONEZONE_IA"
    }
    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_policy" "prevent_deletion" {
  bucket = aws_s3_bucket.lab1.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Deny",
      "Principal": "*",
        "Action": "s3:DeleteBucket",
        "Resource": [
          "${aws_s3_bucket.lab1.arn}",
          "${aws_s3_bucket.lab1.arn}/*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_kms_key" "lab1key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "alias" {
  name          = "alias/lab1-key"
  target_key_id = aws_kms_key.lab1key.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lab1_encrypt" {
  bucket = aws_s3_bucket.lab1.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.lab1key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}