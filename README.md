[✅ Статус: Готов к продакшену]
# 🍪 Cookie Factory: Terraform + Ansible Pipeline

Автоматизированное развёртывание веб-инфраструктуры по принципам IaC.

## 🚀 Быстрый старт
```bash
./apply_infra.sh "MyFactory" 5
ansible-playbook -i inventory/robot_address_book.json playbook.yml
curl http://localhost
```

## 🧠 Архитектура
- 📐 Terraform (эмуляция) → генерирует инвентарь
- 🤖 Ansible → настраивает Nginx, деплоит статику
- 🔄 Идемпотентность: повторный запуск безопасен
