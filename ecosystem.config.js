module.exports = {
  apps: [
    {
      name: "mi-app-node",
      script: "./index.js",
      cwd: "/home/ec2-user/app",
      error_file: "./logs/app-errors.log",
      out_file: "./logs/app-output.log",
      merge_logs: true,
      log_date_format: "YYYY-MM-DD HH:mm:ss",
    },
  ],
};
