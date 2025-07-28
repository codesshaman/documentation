##### Установка клиента

```
sudo apt update
```

```
sudo apt install v2ray
```

##### Настройка конфига

```
sudo cp /etc/v2ray/config.json /etc/v2ray/config_example.json
```

```
sudo nano /etc/v2ray/config.json
```

Клиентский код:

```
{
    "outbounds": [
        {
            "protocol": "shadowsocks",
            "settings": {
                "servers": [
                    {
                        "address": "your.server.ip.here",
                        "port": 8443,
                        "method": "chacha20-ietf-poly1305",
                        "password": "your_password",
                        "ota": true
                    }
                ]
            }
        }
    ],
    "inbounds": [
        {
            "port": 1080,
            "listen": "127.0.0.1",
            "protocol": "socks",
            "settings": {
                "auth": "noauth",
                "udp": true
            }
        }
    ],
    "log": {
        "access": "/var/log/v2ray/access.log",
        "error": "/var/log/v2ray/error.log",
        "loglevel": "info"
  }
}
```

Проверка на ошибки:

```
v2ray test -c /etc/v2ray/config.json
```

##### Настройки логов

```
sudo mkdir /var/log/v2ray/
```

```
sudo touch /var/log/v2ray/access.log
```

```
sudo touch /var/log/v2ray/error.log
```

```
sudo chown nobody:nogroup /var/log/v2ray -R
```

```
sudo chmod 664 /var/log/v2ray -R
```

##### Запуск

```
sudo systemctl enable v2ray
```

```
sudo systemctl start v2ray
```

```
sudo systemctl status v2ray
```

##### Изменение юнита

Меняем юнит, приводим к следующему виду:

```
[Unit]
Description=V2Ray Service
Documentation=https://www.v2ray.com/ https://www.v2fly.org/
After=network-online.target nss-lookup.target

[Service]
Type=simple
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
DynamicUser=false
NoNewPrivileges=true
Environment=V2RAY_LOCATION_ASSET=/etc/v2ray
ExecStart=/usr/bin/v2ray -config /etc/v2ray/config.json
Restart=on-failure
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
```

DynamicUser должно быть false,
User=nobody
Group=nogroup

##### Перезапуск

```
sudo systemctl daemon-reload
```

```
sudo systemctl restart v2ray
```
