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
                        "password": "your_password"
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
    ]
}
```

