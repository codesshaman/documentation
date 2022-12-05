# Развёртывание K3d в Docker

### Шаг 1. Установка Docker

``sudo apt install docker docker-compose``

### Шаг 2. Установка k3d

Wget:
```
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

Curl:
```
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

### Шаг 3. Установка kubectl:

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

``install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl``

### Создание кластера

```
sudo k3d cluster create test-cluster --servers 3 --agents 3 --port 8080:80@loadbalancer --port 8888:8888@loadbalancer --port 8443:443@loadbalancer
```

### Создание конфига

``k3d cluster create test --verbose --trace``

### Удаление кластера

``k3d cluster delete test-cluster``
