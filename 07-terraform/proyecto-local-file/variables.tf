variable "nombre_archivo" {
  description = "Nombre del archivo .txt a crear"
  type        = string
  default     = "archivo"

  validation {
    condition     = can(regex("\\.txt$", var.nombre_archivo))
    error_message = "El nombre del archivo debe terminar con .txt"
  }
}

variable "contenido_archivo" {
  description = "Contenido del archivo .txt"
  type        = string
  default     = "Contenido por defecto del archivo"
}

variable "output_path" {
  description = "Ruta del directorio donde se creará el archivo"
  type        = string
  default     = "./archivos"
}
