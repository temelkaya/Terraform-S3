resource "aws_s3_bucket" "s3" {
  bucket = "s3-bucket-${var.bucket_name}"

  acl = "private"

  tags = {
    Name        = "S3 bucket with rds dumped data"
    Environment = "dev"
  }
}


resource "aws_rds_cluster" "cluster" {
  cluster_identifier  = "aurora-mysql-cluster-${var.cluster_name}"
  engine              = "aurora-mysql"
  engine_version      = "5.7.mysql_aurora.2.07.5"
  port                = 3306
  availability_zones  = ["us-east-1a", "us-east-1b"]
  master_username     = var.rds_master_username
  master_password     = var.rds_master_password
  skip_final_snapshot = true
  apply_immediately   = true

  lifecycle {
    ignore_changes = [engine_version]
  }
}