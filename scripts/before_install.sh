#!/bin/bash
set -e

APP_DIR="/home/ubuntu/app"
LOG_FILE="/home/ubuntu/deploy_debug.log"

echo ">>> [BeforeInstall] Empezando..." >> "$LOG_FILE"

# Detener CloudWatch Agent si existe
sudo systemctl stop amazon-cloudwatch-agent.service || true

# Limpiar solo archivos de la app, no los logs
find "$APP_DIR" -maxdepth 1 -type f -delete || true
rm -rf "$APP_DIR"/.git || true

echo ">>> [BeforeInstall] Terminando..." >> "$LOG_FILE"
