variable "aws_region" {
  type     = string
  nullable = false
}

variable "database_password" {
  type        = string
  description = "DONT_USE_IT_PLEASE_USE_KMS"
  nullable    = false
}

variable "global_tags" {
  type = map(any)
  default = {
    "source" : "test-rds"
    "date" : "05/10/2023"
  }
}
