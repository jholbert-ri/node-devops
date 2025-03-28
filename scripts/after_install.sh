#!/bin/bash
APP_DIR="/home/ec2-user/app"

# Asegurar que el directorio de logs existe y tiene permisos
mkdir -p "$APP_DIR/logs"
chown -R ec2-user:ec2-user "$APP_DIR"
chmod -R 755 "$APP_DIR/logs"  # Permisos de ejecución para directorios

# Permisos para archivos
find "$APP_DIR" -type f -exec chmod 644 {} \;