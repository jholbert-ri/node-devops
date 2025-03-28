#!/bin/bash
set -e

APP_DIR="/home/ec2-user/app"
LOG_FILE="/home/ec2-user/deploy_debug.log"

echo ">>> [ApplicationStart] $(date)" >> "$LOG_FILE"

# Crear directorio de logs de la app
mkdir -p "$APP_DIR/logs"
chown -R ec2-user:ec2-user "$APP_DIR/logs"
chmod -R 755 "$APP_DIR/logs"

# Iniciar aplicación con PM2
cd "$APP_DIR"
pm2 start ecosystem.config.js --env production  # La advertencia persiste pero no es crítica

# Asegurar directorios de CloudWatch Agent
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d
sudo chown -R root:root /opt/aws/amazon-cloudwatch-agent

# Iniciar CloudWatch Agent (verifica la ruta del archivo de configuración)
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

echo ">>> [ApplicationStart] END $(date)" >> "$LOG_FILE"