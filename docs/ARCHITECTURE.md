# Архитектура SCADA-системы

## Общая схема

Система построена по микросервисной архитектуре:

**Data Collection Layer:** Сенсоры IoT + MQTT протокол

**Message Broker:** Mosquitto MQTT Broker (порт 1883), QoS 0, 1, 2

**Processing Layer:** Node-RED (порт 1880) — визуальная обработка потоков

**Storage Layer:** InfluxDB 2.7 (порт 8086) — time-series БД, Flux query language

**Visualization Layer:** Grafana (порт 3000) — дашборды

**Monitoring Layer:**
- Prometheus (19090) — сбор метрик каждые 15 сек
- cAdvisor (8080) — метрики контейнеров
- Node Exporter (9100) — метрики хоста
- Alertmanager (9093) — обработка алертов

**Access Layer:** Nginx (8880/8443) — reverse proxy с SSL + Basic Auth

## Компоненты

### 1. Mosquitto (Message Broker)
- Порт: 1883 (MQTT), 9001 (WebSocket)
- Аутентификация: username/password
- Persistence: включена

### 2. Node-RED (Processing)
- Порт: 1880
- Обработка MQTT, запись в InfluxDB, REST API

### 3. InfluxDB 2.7 (Storage)
- Порт: 8086
- Flux query language
- Buckets: scada_data, _monitoring, _tasks

### 4. Grafana (Visualization)
- Порт: 3000
- Datasources: InfluxDB + Prometheus

### 5. Prometheus Stack (Monitoring)
- Prometheus, cAdvisor, Node Exporter, Alertmanager

### 6. Nginx (Access)
- Порты: 8880 (HTTP), 8443 (HTTPS)
- SSL + Basic Auth

## Сетевая архитектура

Все контейнеры в Docker-сети scada_scada.

| Сервис | Host Port | Container Port |
|--------|-----------|----------------|
| Grafana | 3000 | 3000 |
| Prometheus | 19090 | 9090 |
| Node-RED | 1880 | 1880 |
| InfluxDB | 8086 | 8086 |
| Mosquitto | 1883 | 1883 |
| cAdvisor | 8080 | 8080 |
| Node Exporter | 9100 | 9100 |
| Nginx | 8880/8443 | 80/443 |

## Поток данных

1. Сенсор публикует в MQTT
2. Mosquitto доставляет
3. Node-RED обрабатывает
4. Запись в InfluxDB
5. Grafana запрашивает через Flux
6. Рендеринг дашборда

## Безопасность

- Изолированная Docker-сеть
- SSL/TLS через Nginx
- Basic Auth + API tokens
- Ansible Vault (AES-256)

## Масштабирование

- Горизонтальное: добавление worker nodes
- Вертикальное: увеличение CPU/RAM
- Кластеризация InfluxDB
