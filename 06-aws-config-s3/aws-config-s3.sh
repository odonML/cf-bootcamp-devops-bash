#!/bin/bash

# Terminar el script inmediatamente si ocurre un error
set -e

echo "=== Creador de Sitios Web Estáticos en Amazon S3 ==="
echo ""

# 1. Solicitar datos de forma dinámica
read -p "Ingresa el nombre único para tu nuevo Bucket de S3: " BUCKET_NAME
read -p "Ingresa la ruta de tu archivo index.html (ej. ./index.html): " FILE_PATH
read -p "Ingresa la región de AWS donde deseas crearlo [us-east-1]: " REGION
REGION=${REGION:-us-east-1} # Si se deja vacío, usa us-east-1 por defecto

# Validar que el archivo exista antes de continuar
if [ ! -f "$FILE_PATH" ]; then
    echo "❌ Error: El archivo '$FILE_PATH' no existe. Verifica la ruta."
    exit 1
fi

echo -e "\n⏳ Iniciando despliegue en la región $REGION..."

# 2. Crear el Bucket de S3
# Nota: us-east-1 no requiere LocationConstraint, otras regiones sí.
if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION"
else
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" \
        --create-bucket-configuration LocationConstraint="$REGION"
fi
echo "✅ Bucket '$BUCKET_NAME' creado con éxito."

# 3. Desbloquear el Acceso Público (Desactivar Block Public Access)
echo "🔓 Deshabilitando el bloqueo de acceso público..."
aws s3api put-public-access-block \
    --bucket "$BUCKET_NAME" \
    --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"
echo "✅ Acceso público desbloqueado a nivel de configuración del bucket."

# 4. Aplicar la política de acceso de lectura pública (Bucket Policy)
echo "📄 Aplicando la política de lectura pública (GetObject)..."
POLICY=$(jq -n --arg bucket "$BUCKET_NAME" '{
    Version: "2012-10-17",
    Statement: [
        {
            Sid: "PublicReadGetObject",
            Effect: "Allow",
            Principal: "*",
            Action: "s3:GetObject",
            Resource: "arn:aws:s3:::\($bucket)/*"
        }
    ]
}')

aws s3api put-bucket-policy --bucket "$BUCKET_NAME" --policy "$POLICY"
echo "✅ Política del bucket vinculada exitosamente."

# 5. Configurar el Bucket como un Sitio Web Estático
echo "⚙️ Configurando alojamiento de sitio web estático..."
aws s3api put-bucket-website --bucket "$BUCKET_NAME" \
    --website-configuration '{"IndexDocument": {"Suffix": "index.html"}}'
echo "✅ Características de sitio web estático activadas."

# 6. Subir el archivo index.html dinámico
echo "📤 Subiendo el archivo '$FILE_PATH' como index.html..."
aws s3 cp "$FILE_PATH" "s3://$BUCKET_NAME/index.html" --content-type "text/html"
echo "✅ Archivo subido con éxito."

# 7. Mostrar URL final del sitio
echo -e "\n🚀 ================================================="
echo "🎉 ¡Tu sitio web en AWS S3 está listo!"
echo "🔗 URL Pública:"
# S3 tiene dos formatos de URL estática dependiendo de la región
if [ "$REGION" = "us-east-1" ]; then
    echo "http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
else
    echo "http://$BUCKET_NAME.s3-website.$REGION.amazonaws.com"
fi
echo "===================================================="
