### 1. Установка клиентского пакета OpenVPN.

Устанавливаем клиентский пакет OpenVPN. Используем следующие команды:

``sudo apt update``

``sudo apt install -y openvpn``

### 2. Настройка клиента

Получаем настроенную конфигурацию клиента с сервера по scp:

``scp root@vpnserver.com:/your_path/clientname.ovpn /etc/openvpn/client``

### 3. Перезапуск OpenVPN

``service openvpn restart``

### 4. Тестирование подключения к VPN

Теперь пришло время проверить соединение с сервером VPN с машины Debian.
Чтобы гарантировать соединение проведем сначала тест ping с сервером OpenVPN.
Когда он успешно подключится, мы используем следующую команду для подключения.

``sudo openvpn --config /etc/openvpn/client/clientname.ovpn``

### 5. Автоматизация подключения

Теперь создаём файл

``sudo nano /usr/local/bin/ovpn``

И кладём в него нашу команду запуска:

```
#!/bin/bash

sudo openvpn --config /etc/openvpn/client/clientname.ovpn
```
После этого даём ему права на запуск:

``sudo chmod +x /usr/local/bin/ovpn``

И мы можем запускать соединение командой

``ovpn``

