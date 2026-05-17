output "archivo_ruta" {
  description = "Ruta completa del archivo creado"
  value       = local_file.archivo_txt.filename
}

output "archivo_contenido" {
  description = "Contenido del archivo creado"
  value       = local_file.archivo_txt.content
}

output "archivo_id" {
  description = "ID del archivo (hash del contenido)"
  value       = local_file.archivo_txt.id
}
