# 🛰️ Node.js WebSocket App para EC2

Esta aplicación está diseñada para ser desplegada en instancias EC2 (con o sin autoescalado) y ser usada como endpoint de prueba para balanceadores de carga, CodeDeploy y WebSocket en AWS.

---

## 🚀 Tecnologías utilizadas

- **Node.js + Express**
- **Socket.IO** para WebSockets
- **Endpoints HTTP** para Health Checks
- Compatible con PM2 + CodeDeploy
- Logs preparados para **CloudWatch Logs**

---

## 📦 Instalación local

```bash
npm install
node index.js


## ⚙️ Rutas disponibles

| Ruta         | Tipo | Propósito                                                              | Entorno EC2 asociado                    |
|--------------|------|------------------------------------------------------------------------|-----------------------------------------|
| `/status`    | GET  | Verifica estado general del servicio (CPU, salud)                     | Auto Scaling Group sin WebSocket        |
| `/ws-health` | GET  | Verifica estado de WebSocket y número de clientes conectados          | Auto Scaling Group con WebSocket (WSS)  |
| `/health`    | GET  | Health check básico de instancia única   
