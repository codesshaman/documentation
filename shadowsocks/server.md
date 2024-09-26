### 0. Предустановка необходимых пакетов

``sudo apt update && sudo apt install nano unzip -y``

### 1. Установка пакета shadowsocks от v2ray

Создаём директорию:

``cd /usr/local/bin/ && sudo mkdir v2ray && cd v2ray``

Смотрим последнюю версию пакета c [официального репозитория](https://github.com/v2fly/v2ray-core/releases "скачать v2ray")

Скачиваем пакет:

``sudo curl -LO https://github.com/v2fly/v2ray-core/releases/download/v5.18.0/v2ray-linux-64.zip``

Разархивируем:

``sudo unzip v2ray-linux-64.zip``

### 2. Установка пакета shadowsocks от v2ray



Меняем содержимое конфига на следующее:

```
{
  "inbounds": [
    {
      "port": 443, 
      "protocol": "shadowsocks",
      "settings": {
        "method": "chacha20-ietf-poly1305",
        "ota": true,
        "password": "M%@WvP^kPe9Ne~V&m"
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",  
      "settings": {}
    }
  ]
}

```
используя свои порт и пароль, так же можно менять метод шифрования
