### 0. Предустановка необходимых пакетов

``sudo apt update && sudo apt install nano unzip -y``

### 1. Установка пакета shadowsocks от v2ray

Создаём директорию:

``cd /opt && sudo mkdir v2ray && cd v2ray``

Смотрим последнюю версию пакета c [официального репозитория](https://www.debian.org/](https://github.com/v2fly/v2ray-core/releases "скачать v2ray")

Скачиваем пакет:

``sudo curl -LO https://github.com/v2fly/v2ray-core/releases/download/v5.18.0/v2ray-linux-64.zip``

Разархивируем:

``sudo unzip v2ray-linux-64.zip``

### 2. Установка пакета shadowsocks от v2ray

