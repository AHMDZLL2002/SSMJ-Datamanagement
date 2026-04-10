#!/bin/bash
# =====================================================
# MYSSMJ - Hostinger VPS Setup Script
# Jalankan sekali sahaja pada VPS baru
# Guna: bash setup-vps.sh
# =====================================================

set -e  # Stop on error

APP_DIR="/var/www/myssmj"
DATA_DIR="$APP_DIR/data"
NGINX_CONF="/etc/nginx/sites-available/myssmj"

echo "======================================"
echo " MYSSMJ VPS Setup - Hostinger"
echo "======================================"

# 1. Update system
echo "[1/8] Updating system..."
apt-get update -y && apt-get upgrade -y

# 2. Install Node.js 20
echo "[2/8] Installing Node.js 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# 3. Install PM2 & nginx
echo "[3/8] Installing PM2 and nginx..."
npm install -g pm2
apt-get install -y nginx

# 4. Create app directory
echo "[4/8] Creating app directory..."
mkdir -p "$APP_DIR"
mkdir -p "$DATA_DIR"
chmod 755 "$DATA_DIR"

# 5. Copy nginx config
echo "[5/8] Configuring nginx..."
cp "$APP_DIR/nginx-hostinger.conf" "$NGINX_CONF"
ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/myssmj
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl reload nginx
systemctl enable nginx

# 6. Install dependencies
echo "[6/8] Installing npm packages..."
cd "$APP_DIR"
npm install --production

# 7. Start app with PM2
echo "[7/8] Starting app with PM2..."
cd "$APP_DIR"
pm2 start ecosystem.config.js
pm2 save
pm2 startup

# 8. Setup firewall
echo "[8/8] Configuring firewall..."
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

echo ""
echo "======================================"
echo " Setup Selesai!"
echo " App berjalan di http://YOUR_IP"
echo " Folder app   : $APP_DIR"
echo " Database     : $DATA_DIR/app.db"
echo "======================================"
echo ""
echo "Langkah seterusnya:"
echo "  1. Edit nginx-hostinger.conf - tukar YOUR_DOMAIN.COM"
echo "  2. Run: certbot --nginx -d yourdomain.com  (untuk SSL percuma)"
