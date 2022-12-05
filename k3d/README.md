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
