# SCADA System with Ansible Automation

Production-ready SCADA system with automated deployment using Ansible. The system includes monitoring, data collection, visualization, and alerting — all deployed with a single command.

## What's Inside

8 Docker containers orchestrated by Ansible:

- **Mosquitto** — MQTT broker for IoT communication
- **Node-RED** — visual programming for data processing
- **InfluxDB 2.7** — time-series database for metrics storage
- **Grafana** — dashboards and visualization
- **Prometheus** — metrics collection
- **cAdvisor** — container metrics
- **Node Exporter** — host metrics
- **Alertmanager** — alert routing

Plus:
- Automatic daily backups with 7-day rotation
- Nginx reverse proxy with SSL
- Ansible Vault for secrets management
- CI/CD via GitHub Actions

## Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Automation | Ansible 2.17 | Orchestration |
| Containers | Docker CE + Compose | Isolation |
| SCADA Core | Node-RED, Mosquitto | Logic & messaging |
| Storage | InfluxDB 2.7 | Time-series DB |
| Visualization | Grafana 13 | Dashboards |
| Monitoring | Prometheus + cAdvisor | Metrics |
| Alerting | Alertmanager | Notifications |
| Proxy | Nginx + SSL | Secure access |
| Backups | Bash + Cron | Automation |
| CI/CD | GitHub Actions | Validation |
| VMs | Multipass | Local testing |

## Quick Start

### Prerequisites

- Ubuntu 22.04+
- Docker CE with compose plugin
- Python 3.10+
- Ansible 2.17+

### 1. Clone

```bash
git clone https://github.com/alekseibaranovib2023-alt/portfolio-ansible.git
cd portfolio-ansible
```

### 2. Install collections

```bash
ansible-galaxy collection install -r requirements.yml
```

### 3. Deploy

```bash
# Local deployment
ansible-playbook -i inventory/localhost/hosts.ini playbooks/deploy-scada.yml --vault-password-file .vault_password

# Multipass VMs
ansible-playbook -i inventory/multipass/hosts.ini playbooks/deploy-scada.yml --vault-password-file .vault_password
```

### 4. Access services

| Service | URL | Credentials |
|---------|-----|-------------|
| Grafana | http://localhost:3000 | admin / Gr@f@n@_Secure_2026! |
| Prometheus | http://localhost:19090 | — |
| Node-RED | http://localhost:1880 | — |
| InfluxDB | http://localhost:8086 | admin / InfluxDB_Secure_2026! |
| Mosquitto | mqtt://localhost:1883 | mqtt_user / MQTT_Secure_2026! |

## Architecture

The system follows a layered architecture:

**Data Collection:** Sensors publish to MQTT topics  
**Message Broker:** Mosquitto handles message routing  
**Processing:** Node-RED processes and transforms data  
**Storage:** InfluxDB stores time-series data  
**Visualization:** Grafana displays dashboards  
**Monitoring:** Prometheus + cAdvisor + Node Exporter collect metrics  

All containers run in an isolated Docker network `scada_scada`.

## Security

- **Ansible Vault** — all secrets encrypted with AES-256
- **SSL/TLS** — Nginx reverse proxy with self-signed certificates
- **Basic Auth** — web interfaces protected
- **Docker network** — container isolation

## Monitoring

Prometheus scrapes metrics every 15 seconds from:
- cAdvisor (container metrics)
- Node Exporter (host metrics)
- Grafana (self-monitoring)

Alerts configured for:
- Container down
- CPU > 80%
- RAM > 85%
- Disk > 85%

## Backups

Daily backups at 2:00 AM:
- InfluxDB data (via `influx backup`)
- Grafana dashboards + datasources (via API)
- Node-RED flows + data
- Configuration files

Rotation: 7 days retention, automatic cleanup.

## Project Structure

```
portfolio-ansible/
├── ansible.cfg
├── requirements.yml
├── secrets.yml (encrypted)
├── .vault_password
├── inventory/
│   ├── localhost/
│   └── multipass/
├── playbooks/
│   ├── deploy-scada.yml
│   ├── deploy-nginx.yml
│   └── backup-scada.yml
├── roles/
│   ├── scada/
│   ├── nginx/
│   └── backup/
└── docs/
    ├── ARCHITECTURE.md
    ├── DEPLOYMENT.md
    └── TROUBLESHOOTING.md
```

## What I Learned

Building this project taught me:

- **Ansible roles** — how to structure reusable automation
- **Docker networking** — isolated networks for microservices
- **API automation** — configuring Grafana, InfluxDB, Node-RED via REST API
- **Idempotency** — making playbooks safe to run multiple times
- **Secret management** — using Ansible Vault for credentials
- **Multi-host deployment** — SSH key-based auth between VMs
- **Backup strategies** — automated backups with rotation
- **CI/CD** — GitHub Actions for ansible-lint validation

## Challenges Faced

1. **Docker Compose plugin** — had to install Docker CE from official repo instead of Ubuntu's `docker.io` package
2. **Ansible version compatibility** — community.docker collection required Ansible 2.17+, had to upgrade from 2.10
3. **Node-RED flow deployment** — HTTP 204 response instead of 200, had to adjust expected status codes
4. **Multipass networking** — MTU issues with Docker inside VMs, fixed by setting MTU to 1450
5. **Vault password management** — ensuring `.vault_password` is never committed to Git

## Documentation

- [ARCHITECTURE.md](docs/ARCHITECTURE.md) — Detailed system design
- [DEPLOYMENT.md](docs/DEPLOYMENT.md) — Step-by-step deployment guide
- [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) — Common problems and solutions

## Future Plans

- Migrate to Kubernetes with Helm charts
- Add Terraform for infrastructure provisioning
- Integrate with HashiCorp Vault for secrets
- Add more alerting rules and dashboards

## License

MIT License — see [LICENSE](LICENSE) file
