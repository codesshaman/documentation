
### 1. Установка клиентского пакета Shadowsocks.

Устанавливаем клиентский пакет shadowsocks-libev. Используем следующие команды:


``sudo apt install shadowsocks-libev``

Открываем конфиг

``sudo nano /etc/shadowsocks-libev/config.json``

Вносим свои данные и сохраняем

### 2. Настройка запуска

Готовая команда запуска:

``sudo ss-local -v -c /etc/shadowsocks-libev/config.json``

Автоматизируем запуск:

``sudo nano /usr/local/bin/shadowsocks``

Вставляем код:

```
#!/bin/bash
sudo ss-local -v -c /etc/shadowsocks-libev/config.json
```
Даём права на исполнение:

``sudo chmod +x /usr/local/bin/shadowsocks``

### 3. Запуск

``shadowsocks``

