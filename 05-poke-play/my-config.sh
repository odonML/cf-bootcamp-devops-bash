#!/bin/bash
# Colores para la salida
GREEN='\033[0/32m'
RED='\033[0/31m'
BLUE='\033[0/34m'
YELLOW='\033[0/33m'
NC='\033[0m' # No Color

printInfo() {
    echo -e "${BLUE}>>> $1${NC}"
}
printError() {
    echo -e "${RED}>>> $1${NC}"
}
printWarning() {
    echo -e "${YELLOW}>>> $1${NC}"
}
printSuccess() {
    echo -e "${GREEN}>>> $1${NC}"
}

# --- CONFIGURACIÓN ---
APP_NAME="pokemon_game" # Cambia esto por tu IP o dominio
WEB_ROOT="/var/www/html/${APP_NAME}" # estaticos de nginx
NGINX_CONF="/etc/nginx/sites-available/${APP_NAME}" # sitios habilitados de nginx

printInfo "Verificando instalación de Nginx..."
if command -v nginx >/dev/null 2>&1; then
    printSuccess "Nginx ya está instalado."
else
    printInfo "Instalando Nginx..."
    sudo apt update && sudo apt install -y nginx sudo
    sudo service nginx start
    sudo service nginx enable
fi

printInfo "Iniciando despliegue de la web..."

# 1. Crear el directorio de la web si no existe
sudo mkdir -p $WEB_ROOT


# 2. Copiar el archivo index.html al directorio (asumiendo que está en la misma carpeta que el script)
if [ -f "index.html" ]; then
    cp ./* $WEB_ROOT/
    sudo chown -R www-data:www-data $WEB_ROOT
    printSuccess "Documento index.html copiado a $WEB_ROOT"
else
    printError "Error: index.html no encontrado en el directorio actual."
    exit 1
fi

# 3. Crear la configuración de Nginx
printInfo "Configurando Nginx..."
sudo bash -c "cat > $NGINX_CONF" <<EOF
server {
    listen 80;
    server_name "localhost";

    root $WEB_ROOT;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# 4. Habilitar el sitio y reiniciar Nginx
sudo ln -sf $NGINX_CONF /etc/nginx/sites-enabled/
sudo nginx -t && sudo service nginx restart

printSuccess "¡Despliegue completado con éxito!"
echo "Visita: http://${APP_NAME} para ver tu aplicación en acción."