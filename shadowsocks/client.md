

``sudo apt install shadowsocks-libev``

``sudo cp ./shadowsocks-client.json /etc/shadowsocks-libev/config.json``

``sudo nano /etc/systemd/system/ss-local.service``

```
[Unit]
Description=Daemon to start Shadowsocks Client
Wants=network-online.target
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/ss-local -c /etc/shadowsocks-libev/config.json

[Install]
WantedBy=multi-user.target
```

```
$ sudo systemctl daemon-reload
$ sudo systemctl enable ss-local.service
$ sudo systemctl restart ss-local.service

$ sudo  systemctl status ss-local.service
```wh
