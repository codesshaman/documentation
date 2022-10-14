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