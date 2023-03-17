# Установка и настройка supervisor

## Установка:

**apt install supervisor
update-rc.d supervisor defaults**

## Запуск сервиса:

**systemctl enable supervisor
systemctl start supervisor**

## Запуск сокета:

**supervisorctl update
supervisorctl start websockets**

### Путь к конфигам:

**/etc/supervisor/conf.d/**

### Пример конфига:

``websocker.conf``

```
[program:websockets]
process_name=%(program_name)s
command=sudo php artisan websockets:serve --port=8443
directory=/var/www/html/PROJECT_NAME_HERE
autostart=true
autorestart=true
user=root
redirect_stderr=true
stdout_logfile=/var/www/html/PROJECT_NAME_HERE/storage/logs/websockets.log
```
