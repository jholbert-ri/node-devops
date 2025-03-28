#!/bin/bash
set -e

APP_DIR="/home/ec2-user/app"
LOG_FILE="/home/ec2-user/deploy_debug.log"

echo ">>> [BeforeInstall] Empezando..." >> "$LOG_FILE"

# Detener CloudWatch Agent
sudo systemctl stop amazon-cloudwatch-agent.service || true

# Limpiar solo archivos de la app, no los logs
find "$APP_DIR" -maxdepth 1 -type f -delete  # Borra solo archivos, no subdirectorios
rm -rf "$APP_DIR"/.git || true  # Si usas git, elimina la carpeta .git

echo ">>> [BeforeInstall] Terminando..." >> "$LOG_FILE"