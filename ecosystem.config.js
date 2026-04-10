module.exports = {
  apps: [
    {
      name: 'myssmj-app',
      script: 'server.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '512M',
      env: {
        NODE_ENV: 'production',
        PORT: 3000,
        DB_PATH: '/var/www/myssmj/data/app.db',
        SESSION_SECRET: 'TUKAR-KEPADA-STRING-RAWAK-PANJANG-DI-SINI'
      }
    }
  ]
};
