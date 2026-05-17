terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9.0"
    }
  }
}

provider "local" {}

# Recurso para crear un archivo .txt en el directorio local
resource "local_file" "archivo_txt" {
  filename = "${var.output_path}/${var.nombre_archivo}"
  content  = var.contenido_archivo
}
