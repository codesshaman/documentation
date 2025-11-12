# Node exporter install
Instruction for node exporter install

## Скачивание node_exporter

1) Скачать архив [c официального git](https://github.com/prometheus/node_exporter/releases/ "скачать prometheus"). Для версии 1.5.0:

```
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
```

2) Разархивировать:

```
tar xvfz node_exporter-*.linux-amd64.tar.gz
```

3) Перейти в каталог:

```
cd node_exporter-*.*-amd64
```

4) Копировать файл в /usr/bin:

```
sudo cp node_exporter /usr/bin
```

## Установка node_exporter

### СПОСОБ 1 (Предпочтительный). Systemd

1) Создаём системного пользователя для работы демона:

```
sudo useradd -r -M -s /bin/false node_exporter
```

2) Меняем пользователя файла на созданного:

```
sudo chown node_exporter:node_exporter /usr/bin/node_exporter
```

3) Создаём юнита:

```
sudo nano /etc/systemd/system/node_exporter.service
```

```
[Unit]
Description=Prometheus Node Exporter

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

4) Обновляем список сервисов:

```
sudo systemctl daemon-reload
```

5) Включаем демона:

```
sudo systemctl enable --now node_exporter
```

6) Проверяем, что всё работает:

```
sudo systemctl status node_exporter
```

### СПОСОБ 2. Supervisor

## Установка supervisor

1) ``sudo apt update && sudo apt install supervisor``
2) ``sudo systemctl status supervisor``

## Конфигурация supervisor

``sudo nano /etc/supervisor/conf.d/node_exporter.conf``

```
[program:node_exporter]
command=/usr/bin/node_exporter
autostart=true
autorestart=true
stderr_logfile=/var/log/node_exporter.err.log
stdout_logfile=/var/log/node_exporter.out.log
```
## Перезапуск демона supervisor

``sudo supervisorctl reread``

Результат: ``node_exporter: available``

## Открытие порта

``sudo ufw allow 9100``

Результат:

```
Rule added
Rule added (v6)
```

## WEB GUI:

``http://server-name:9100``
