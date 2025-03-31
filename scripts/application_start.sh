#!/bin/bash
set -e

APP_DIR="/home/ubuntu/app"
LOG_FILE="/home/ubuntu/deploy_debug.log"

echo ">>> [ApplicationStart] $(date)" >> "$LOG_FILE"

# Crear directorio de logs de la app
mkdir -p "$APP_DIR/logs"
chown -R ubuntu:ubuntu "$APP_DIR/logs"
chmod -R 755 "$APP_DIR/logs"

# Iniciar aplicación con PM2
cd "$APP_DIR"
pm2 start ecosystem.config.js --env production

# Asegurar directorios de CloudWatch Agent
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d
sudo chown -R root:root /opt/aws/amazon-cloudwatch-agent

# (OJO: este paso se omite si el agent se inicia desde userData)

echo ">>> [ApplicationStart] END $(date)" >> "$LOG_FILE"
