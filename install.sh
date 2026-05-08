#!/data/data/com.termux/files/usr/bin/bash

clear

echo "🔥 INSTALLING GCASH VENDO..."

# ================= UPDATE =================
pkg update -y
pkg upgrade -y

# ================= INSTALL =================
pkg install php git openssl -y

# ================= REMOVE OLD =================
rm -rf ~/htdocs
mkdir -p ~/htdocs

# ================= COPY FILES =================
cp -r * ~/htdocs/

# ================= GO TO HTDOCS =================
cd ~/htdocs

# ================= CREATE API KEY =================
API_KEY=$(openssl rand -hex 6)

# ================= UPDATE CONFIG =================
cat > config.json <<EOF
{
    "api_key": "$API_KEY",
    "earnings": 0
}
EOF

# ================= GET IP =================
IP=$(ip route get 1 | awk '{print $7;exit}')

if [ -z "$IP" ]; then
IP="127.0.0.1"
fi

# ================= LINKS =================
INDEX_LINK="http://$IP:8080/index.php"
ADMIN_LINK="http://$IP:8080/admin.php"
API_LINK="http://$IP:8080/api.php?key=$API_KEY&amount=10"

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
