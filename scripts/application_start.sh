#!/bin/bash
set -e

APP_DIR="/home/ec2-user/app"
LOG_FILE="/home/ec2-user/deploy_debug.log"

echo ">>> [ApplicationStart] $(date)" >> "$LOG_FILE"

# Crear directorios críticos
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d
sudo chown -R root:root /opt/aws/amazon-cloudwatch-agent

# Configuración inicial de CloudWatch Agent (si no existe)
if [ ! -f "/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json" ]; then
  echo "Creando configuración por defecto de CloudWatch Agent" >> "$LOG_FILE"
  sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOF
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/home/ec2-user/app/logs/*.log",
            "log_group_name": "mi-app-node-logs",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
EOF
fi

# Reiniciar CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a stop || true
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start -s

# Iniciar aplicación con PM2 usando el entorno production
cd "$APP_DIR"
pm2 start ecosystem.config.js --env production

echo ">>> [ApplicationStart] END $(date)" >> "$LOG_FILE"