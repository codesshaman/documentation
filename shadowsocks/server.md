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

### 2. Создаём конфигурационный файл

Создаём файл в /usr/local/etc/v2ray:

``cd /usr/local/etc/ && sudo mkdir v2ray && cd v2ray && sudo touch config.json``

Меняем содержимое конфига на следующее:

``sudo nano config.json``

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

### 3. Создаём системного демона из готового шаблона

Копируем шаблон в папку systemd:

``sudo cp /usr/local/bin/v2ray/systemd/system/v2ray.service /etc/systemd/system``

Меняем путь к v2ray на корректный:

`` sudo sed -i 's!/usr/local/bin/v2ray!/usr/local/bin/v2ray/v2ray!1' /etc/systemd/system/v2ray.service``

Перезапускаем system control manager:

``sudo systemctl daemon-reload``

Проверяем что наш демон зарегистрирован:

``sudo systemctl status v2ray``

Видим что демон мёртв: ``inactive (dead)``
Перезапускаем демона:

``sudo systemctl restart v2ray``

Ещё раз проверяем статус:

``sudo systemctl status v2ray``

Видим что демон работает и всё ок
