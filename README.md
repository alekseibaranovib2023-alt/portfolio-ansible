# SCADA System with Ansible Automation

**Полноценная SCADA-система с автоматическим развёртыванием через Ansible**

## Описание

Проект демонстрирует production-ready SCADA-систему с полной автоматизацией развёртывания.

### Ключевые возможности

- Автоматическое развёртывание одной командой
- 8 микросервисов в Docker-контейнерах
- Multi-host поддержка (развёртывание на удалённые серверы)
- Мониторинг через Prometheus + Grafana + cAdvisor
- Автоматические бэкапы всех данных
- SSL/TLS через Nginx reverse proxy
- Безопасность через Ansible Vault
- CI/CD через GitHub Actions

## Архитектура

**SCADA Core:**
- Mosquitto (MQTT Broker) — обмен сообщениями
- Node-RED — обработка данных
- InfluxDB — хранение time-series данных
- Grafana — визуализация

**Monitoring Stack:**
- Prometheus — сбор метрик
- cAdvisor — метрики Docker-контейнеров
- Node Exporter — метрики хоста
- Alertmanager — обработка алертов

**Security and Access:**
- Nginx — reverse proxy с SSL
- Ansible Vault — управление секретами

## Технологический стек

| Компонент | Технология | Назначение |
|-----------|------------|------------|
| Автоматизация | Ansible 2.17 | Оркестрация |
| Контейнеризация | Docker CE + Compose | Изоляция |
| SCADA ядро | Node-RED, Mosquitto | Логика |
| Хранение | InfluxDB 2.7 | Time-series БД |
| Визуализация | Grafana 13 | Дашборды |
| Мониторинг | Prometheus + cAdvisor | Метрики |
| Алертинг | Alertmanager | Уведомления |
| Proxy | Nginx + SSL | Безопасный доступ |
| Бэкапы | Bash + Cron | Автоматизация |
| CI/CD | GitHub Actions | Проверки |
| Виртуализация | Multipass | VM для тестов |

## Быстрый старт

### Требования

- Ubuntu 22.04+
- Docker CE с compose plugin
- Python 3.10+
- Ansible 2.17+

### 1. Клонирование

```bash
git clone https://github.com/alekseibaranovib2023-alt/portfolio-ansible.git
cd portfolio-ansible
```

### 2. Установка коллекций

```bash
ansible-galaxy collection install -r requirements.yml
```

### 3. Развёртывание

```bash
# На локальный хост
ansible-playbook -i inventory/localhost/hosts.ini playbooks/deploy-scada.yml --vault-password-file .vault_password

# На VM (Multipass)
ansible-playbook -i inventory/multipass/hosts.ini playbooks/deploy-scada.yml --vault-password-file .vault_password
```

### 4. Доступ к сервисам

| Сервис | URL | Логин/Пароль |
|--------|-----|----------------|
| Grafana | http://localhost:3000 | admin / Gr@f@n@_Secure_2026! |
| Prometheus | http://localhost:19090 | — |
| Node-RED | http://localhost:1880 | — |
| InfluxDB | http://localhost:8086 | admin / InfluxDB_Secure_2026! |
| Mosquitto | mqtt://localhost:1883 | mqtt_user / MQTT_Secure_2026! |

## Безопасность

- Ansible Vault — секреты зашифрованы AES-256
- SSL/TLS — Nginx reverse proxy
- Basic Auth — защита веб-интерфейсов
- Docker network — изоляция контейнеров

## Мониторинг

Prometheus собирает метрики с cAdvisor, Node Exporter, Grafana. Алерты на падение контейнеров, CPU > 80%%, RAM > 85%%, Disk > 85%%.

## Бэкапы

Ежедневные бэкапы в 2:00: InfluxDB, Grafana, Node-RED, configs. Ротация: 7 дней.

## Документация

- [ARCHITECTURE.md](docs/ARCHITECTURE.md) — Детальная архитектура
- [DEPLOYMENT.md](docs/DEPLOYMENT.md) — Инструкция по развёртыванию
- [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) — Решение проблем

## Roadmap

- Интеграция с Kubernetes
- Поддержка AWS/GCP/Azure
- Terraform для инфраструктуры
- HashiCorp Vault интеграция

## Лицензия

MIT License — см. [LICENSE](LICENSE)

---

**Если проект полезен, поставьте звезду на GitHub!**
