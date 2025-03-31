#!/bin/bash

APP_DIR="/home/ubuntu/app"

# Asegurar que el directorio de logs existe y tiene permisos
mkdir -p "$APP_DIR/logs"
chown -R ubuntu:ubuntu "$APP_DIR"
chmod -R 755 "$APP_DIR/logs"

# Permisos para archivos
find "$APP_DIR" -type f -exec chmod 644 {} \;
