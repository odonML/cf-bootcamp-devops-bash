variable "bucket_name" {
  description = "Nombre del bucket de S3 para el sitio web"
  type        = string
  default     = "cf-bootcamp-website-hosting"
}

variable "env" {
  description = "Ambiente del proyecto"
  type        = string
  default     = "dev"
}
