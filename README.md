# Portfolio Ansible Project

Автоматизация инфраструктуры с использованием Ansible, Docker, Kubernetes и Terraform.

## Структура проекта

- `ansible.cfg` - конфигурация Ansible
- `inventory/` - inventory файлы (dev/prod/staging)
- `playbooks/` - playbook'и
- `roles/` - Ansible роли
- `group_vars/` - групповые переменные
- `templates/` - Jinja2 шаблоны
- `files/` - статические файлы
- `tests/` - тесты (Molecule)

## Быстрый старт

1. Установка коллекций: `ansible-galaxy install -r requirements.yml`
2. Запуск SCADA: `cd playbooks/scada && docker compose up -d`
3. Запуск playbook: `ansible-playbook playbooks/playbook.yml`
