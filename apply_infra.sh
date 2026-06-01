#!/bin/bash
# 📐 Волшебный Чертежник: создаёт адресную книжку для Робота
FACTORY="${1:-CookieFactory}"
OVENS="${2:-3}"

mkdir -p inventory
cat > inventory/robot_address_book.json << JSONEOF
{
  "all": {
    "hosts": {
      "localhost": {
        "ansible_connection": "local",
        "factory_name": "$FACTORY",
        "oven_count": $OVENS,
        "built_at": "$(date -Iseconds)"
      }
    }
  }
}
JSONEOF
echo "✅ Фабрика '$FACTORY' ($OVENS печей) готова! 📄 inventory/robot_address_book.json"
