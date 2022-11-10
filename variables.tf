variable "bucket_name" {
  type    = string
  default = "orchsky-terraform-bucket"
}

variable "cluster_name" {
  type    = string
  default = "orchsky-terraform-cluster"
}

variable "aws_az_count" {
  type    = number
  default = 2
}

variable "rds_master_username" {
    type = string 
    default = "admin"
  
}

variable "rds_master_password" {
    type = string 
    default = "abc12342334555"
  
}
