# Systemd сервис и таймер

## Пример юнита:

``/usr/lib/systemd/system/token_update.service``

```
[Unit]
Description=Test unit

[Service]
User=username
Group=username
Type=simple
ExecStart=/path/to/script.sh

[Install]
WantedBy=multi-user.target
```

## Пример таймера:

``/usr/lib/systemd/system/token_update.timer``

```
[Unit]
Description=Test timer

[Timer]
OnCalendar=daily
AccuracySec=1h
Persistent=true

[Install]
WantedBy=timers.target
```

## Запуск юнита:

``sudo systemctl start token_update.service``

``sudo systemctl status token_update.service``

## Запуск таймера:

``sudo systemctl start token_update.timer``

``sudo systemctl status token_update.timer``

