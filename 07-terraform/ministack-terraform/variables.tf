variable "bucket_name" {
  description = "Nombre del bucket de S3"
  type        = string
  default     = "my-tf-test-bucket-cf-bootcamp"
}

variable "env" {
  description = "ambiente del proyecto"
  type        = string
  default     = "dev"
}

