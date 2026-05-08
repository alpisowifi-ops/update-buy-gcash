#!/data/data/com.termux/files/usr/bin/bash

clear

echo "🔥 INSTALLING GCASH VENDO..."

# ================= UPDATE =================
pkg update -y
pkg upgrade -y

# ================= INSTALL PACKAGES =================
pkg install php git openssl -y

# ================= REMOVE OLD FILES =================
echo ""
echo "🗑 Removing old files..."

rm -rf ~/htdocs

# ================= CREATE NEW HTDOCS =================
mkdir -p ~/htdocs

# ================= COPY FILES =================
cp -r * ~/htdocs/

cd ~/htdocs

# ================= GENERATE RANDOM API KEY =================
API_KEY=$(openssl rand -hex 6)

# ================= UPDATE CONFIG =================
cat > config.json <<EOF
{
    "api_key": "$API_KEY",
    "earnings": 0
}
EOF

# ================= GET LOCAL IP =================
IP=$(ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

# fallback
if [ -z "$IP" ]; then
IP="127.0.0.1"
fi

# ================= BUILD LINKS =================
INDEX_LINK="http://$IP:8080"
API_LINK="http://$IP:8080/api.php?key=$API_KEY&amount=10"
ADMIN_LINK="http://$IP:8080/admin.php"

clear

echo ""
echo "====================================="
echo "✅ GCASH VENDO INSTALLED SUCCESSFULLY"
echo "====================================="
echo ""

echo "🌐 INDEX:"
echo "$INDEX_LINK"
echo ""

echo "⚙️ ADMIN:"
echo "$ADMIN_LINK"
echo ""

echo "🔑 RANDOM API KEY:"
echo "$API_KEY"
echo ""

echo "⚡ MACRODROID API:"
echo "$API_LINK"
echo ""

echo "🚀 SERVER STARTING..."
echo ""

# ================= START SERVER =================
php -S 0.0.0.0:8080
