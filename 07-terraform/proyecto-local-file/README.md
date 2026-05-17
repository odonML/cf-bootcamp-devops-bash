# Proyecto Terraform - Crear Archivo Local

Este proyecto de Terraform crea un archivo `.txt` localmente utilizando el provider `hashicorp/local` versión 2.9.0.

## Características

- ✅ Crea un archivo `.txt` con nombre y contenido configurables
- ✅ Soporta variables de Terraform
- ✅ Soporta variables de entorno
- ✅ Output de la ruta completa del archivo creado
- ✅ `.gitignore` preconfigurado para seguridad

## Estructura del Proyecto

```
proyecto-local-file/
├── main.tf              # Configuración del provider y recurso local_file
├── variables.tf         # Declaración de variables
├── outputs.tf           # Outputs del proyecto
├── .gitignore           # Archivos a ignorar en Git
├── terraform.tfvars.example  # Ejemplo de valores (NO subir a Git)
└── README.md            # Este archivo
```

## Uso

### 1. Opción A: Usando `terraform.tfvars`

```bash
# Copiar el archivo de ejemplo
cp terraform.tfvars.example terraform.tfvars

# Editar terraform.tfvars con tus valores
nano terraform.tfvars

# Aplicar la configuración
terraform init
terraform plan
terraform apply
```

### 2. Opción B: Usando variables de línea de comandos

```bash
terraform init
terraform apply \
  -var="nombre_archivo=mi-archivo.txt" \
  -var="contenido_archivo=Contenido del archivo"
```

### 3. Opción C: Usando variables de entorno

```bash
export TF_VAR_nombre_archivo="archivo-env.txt"
export TF_VAR_contenido_archivo="Contenido desde variable de entorno"

terraform init
terraform apply
```

## Variables

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `nombre_archivo` | Nombre del archivo .txt a crear | `archivo.txt` |
| `contenido_archivo` | Contenido del archivo | `Contenido por defecto del archivo` |
| `output_path` | Ruta del directorio de salida | `${path.module}/archivos` |

## Outputs

El proyecto proporciona los siguientes outputs:

- **`archivo_ruta`**: Ruta completa del archivo creado
- **`archivo_contenido`**: Contenido del archivo
- **`archivo_id`**: ID del archivo (hash SHA1 del contenido)

## Ejemplo de Ejecución

```bash
# Inicializar Terraform
$ terraform init

# Planificar cambios
$ terraform plan -var="nombre_archivo=saludo.txt" -var="contenido_archivo=¡Hola Terraform!"

# Aplicar cambios
$ terraform apply -var="nombre_archivo=saludo.txt" -var="contenido_archivo=¡Hola Terraform!" -auto-approve

# Ver outputs
$ terraform output
archivo_ruta = "/Users/odonlozadacarrasco/Develop/Study/cf-bootcamp-devops-bash/07-terraform/proyecto-local-file/archivos/saludo.txt"
archivo_contenido = "¡Hola Terraform!"
archivo_id = "abc123..."
```

## Seguridad

⚠️ **IMPORTANTE**: 
- El archivo `.gitignore` está configurado para ignorar archivos `.txt` y la carpeta `archivos/`
- **No subas** `terraform.tfvars` a GitHub (contiene valores sensibles)
- Usa `terraform.tfvars.example` como referencia

## Destruir los recursos

```bash
terraform destroy
```

## Provider

- **Proveedor**: HashiCorp Local
- **Versión**: ~> 2.9.0
- **Recurso Principal**: `local_file`
