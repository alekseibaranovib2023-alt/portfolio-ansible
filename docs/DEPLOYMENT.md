# Инструкция по развёртыванию

## Требования

- Ubuntu 22.04+ / Debian 11+
- Docker CE с compose plugin
- Python 3.10+
- Ansible 2.17+
- RAM: минимум 4 GB
- Диск: минимум 20 GB

## Установка зависимостей

### Ubuntu/Debian

```bash
# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Ansible
pip3 install ansible-core==2.17.0

# Коллекции
ansible-galaxy collection install -r requirements.yml
```

## Развёртывание на локальный хост

```bash
git clone https://github.com/alekseibaranovib2023-alt/portfolio-ansible.git
cd portfolio-ansible

ansible-playbook -i inventory/localhost/hosts.ini playbooks/deploy-scada.yml --vault-password-file .vault_password
```

## Развёртывание на VM (Multipass)

```bash
# Создание VM
multipass launch --name scada-master --cpus 2 --memory 4G --disk 20G jammy
multipass launch --name scada-worker-1 --cpus 2 --memory 2G --disk 10G jammy
multipass launch --name scada-worker-2 --cpus 2 --memory 2G --disk 10G jammy

# Запуск playbook
ansible-playbook -i inventory/multipass/hosts.ini playbooks/deploy-scada.yml --vault-password-file .vault_password
```

## Проверка работоспособности

```bash
docker ps
curl -s http://localhost:3000/api/health | jq "."
curl -s http://localhost:19090/-/healthy
curl -s -o /dev/null -w "%{http_code}" http://localhost:8086/ping
```

## Обновление

```bash
cd /opt/scada
docker compose pull
docker compose up -d
```

## Удаление

```bash
cd /opt/scada && docker compose down
docker volume rm scada_grafana-data scada_influxdb-data scada_nodered-data scada_prometheus-data
sudo rm -rf /opt/scada /opt/backups /opt/nginx
```
