# Решение проблем

## Docker проблемы

### Cannot connect to the Docker daemon
```bash
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker
```

### port is already allocated
```bash
sudo lsof -i :3000
sudo kill -9 <PID>
```

### no space left on device
```bash
docker system prune -a --volumes
df -h
```

## Ansible проблемы

### could not resolve module/action
```bash
ansible-galaxy collection install community.docker community.general
```

### SSH Error: data could not be sent
```bash
ssh -v user@host
ssh-copy-id user@host
```

## Сервисы не запускаются

### Проверка логов
```bash
docker logs scada-grafana --tail 50
docker logs scada-influxdb --tail 50
docker logs scada-prometheus --tail 50
```

### Перезапуск
```bash
docker restart scada-grafana scada-influxdb scada-prometheus
```

## Проблемы с сетью

### Контейнеры не видят друг друга
```bash
docker network inspect scada_scada
docker network create scada_scada
```

### Нет доступа извне
```bash
sudo ufw allow 3000 19090 1880 8086
```

## Полезные команды

```bash
docker ps -a                          # Все контейнеры
docker compose logs -f                # Логи
docker stats --no-stream              # Ресурсы
docker system df -v                   # Дисковое пространство
```
