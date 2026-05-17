terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }
  }
}

provider "local" {
  # Configuration options
}

resource "local_file" "foo" {
  content  = var.content
  filename = "cf-${var.filename}"
}

resource "local_file" "drink" {
  content  = var.content
  filename = "cf2-${var.filename}"
}