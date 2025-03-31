const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const os = require("os");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
  transports: ["websocket", "polling"],
});

const PORT = 3001;

// Configuración de WebSockets
io.on("connection", (socket) => {
  console.log("Nuevo cliente conectado");

  socket.on("mensaje", (data) => {
    console.log("Mensaje recibido:", data);

    io.emit("mensaje", {
      from: socket.id,
      message: data,
      timestamp: new Date().toISOString(),
    });
  });

  socket.on("disconnect", () => {
    console.log("Cliente desconectado:", socket.id);
  });
});

// Ruta /status (para autoescalado sin WSS)
app.get("/status", (req, res) => {
  console.log("Testing Status Route", new Date().toISOString())
  res.status(200).json({
    status: "ok",
    instance: os.hostname(),
    timestamp: new Date().toISOString(),
  });
});

// Ruta /ws-health (para WSS)
app.get("/ws-health", (req, res) => {
  console.log("Testing ws-health Route", new Date().toISOString())
  res.status(200).json({
    status: "ok",
    websocket: io.engine.clientsCount > 0 ? "active" : "idle",
    connectedClients: io.engine.clientsCount,
    timestamp: new Date().toISOString(),
  });
});

// Ruta /health (para instancia EC2 sin autoscaling)
app.get("/health", (req, res) => {
  console.log("Testing health Route", new Date().toISOString())
  res.status(200).send("OK");
});

// Manejar cierre limpio
process.on("SIGINT", () => {
  console.log("\nCerrando servidores...");

  io.close(() => {
    console.log("Servidor WebSocket cerrado");

    server.close(() => {
      console.log("Servidor HTTP cerrado");
      process.exit(0);
    });
  });

  setTimeout(() => {
    console.error("Cierre forzado por timeout");
    process.exit(1);
  }, 5000);
});

// Iniciar el servidor
server.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
  console.log(`WebSocket disponible en ws://localhost:${PORT}`);
});
