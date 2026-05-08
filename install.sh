#!/data/data/com.termux/files/usr/bin/bash

clear

echo "========================================"
echo " INSTALLING GCASH VENDO SYSTEM"
echo "========================================"

pkg update -y
pkg install -y php git openssl-tool

cd ~

rm -rf update-buy-gcash

git clone https://github.com/alpisowifi-ops/update-buy-gcash.git

cd update-buy-gcash || exit

# =========================
# RANDOM API KEY
# =========================
KEY=$(openssl rand -hex 8)

# =========================
# CREATE CONFIG
# =========================
cat > config.json <<EOF
{
  "api_key": "$KEY",
  "qr": "qr.jpg",
  "rates": [
    {
      "amount": 10,
      "label": "10 Hours"
    },
    {
      "amount": 20,
      "label": "4 Hours"
    },
    {
      "amount": 30,
      "label": "1 Day"
    }
  ],
  "earnings": 0
}
EOF

# =========================
# CREATE FILES
# =========================
echo "[]" > vouchers.json
echo "[]" > logs.json
echo "{}" > tokens.json
echo "" > current.txt

# =========================
# DISPLAY INFO
# =========================
IP=$(ifconfig wlan0 | grep "inet " | awk '{print $2}')

clear

echo "========================================"
echo "✅ GCASH VENDO INSTALLED SUCCESSFULLY"
echo "========================================"
echo ""
echo "🌐 INDEX:"
echo "http://127.0.0.1:8080/index.php"
echo ""
echo "⚙️ ADMIN:"
echo "http://127.0.0.1:8080/admin.php"
echo ""
echo "🔑 RANDOM API KEY:"
echo "$KEY"
echo ""
echo "⚡ MACRODROID API:"
echo "http://127.0.0.1:8080/api.php?key=$KEY&amount=10"
echo ""
echo "📡 WIFI API:"
echo "http://$IP:8080/api.php?key=$KEY&amount=10"
echo ""
echo "🚀 SERVER STARTING..."
echo ""

php -S 0.0.0.0:8080
