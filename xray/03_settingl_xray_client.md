#### From non-root user!

Create xray config in the user home folder:

```
nano ~/client-config.json
```

Paste configuration (example for VMess):

```
{
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
  "outbounds": [
    {
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "АДРЕС_СЕРВЕРА",
            "port": ПОРТ,
            "users": [
              {
                "id": "UUID",
                "alterId": 0,
                "security": "auto"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",  // если ты используешь websocket
        "wsSettings": {
          "path": "/Uept9vMjKRW" // путь из панели x-ui
        }
      }
    }
  ]
}
```

