### 1. Установка клиентского пакета OpenVPN.

Устанавливаем клиентский пакет OpenVPN. Используем следующие команды:

``sudo apt update``

``sudo apt install openvpn``

### 2. Настройка клиента

Следующим шагом мы настраиваем клиент OpenVPN. Сервер OpenVPN создает сертификаты
для каждой клиентской машины VPN. Эти сертификаты должны быть доступны на клиентском
компьютере в каталоге /etc/openvpn. Обычно мы используем команду scp и копируем эти
файлы с сервера OpenVPN на машину Debian.

``scp root@vpnserver.com: /etc/openvpn/clients/clientname.tar.gz``

``tar -xzvf clientname.tar.gz``

Это позволит получить все клиентские сертификаты с сервера OpenVPN. Далее копируем
образец файла конфигурации OpenVPN с помощью команды:

``cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf/  etc/openvpn``

Теперь пришло время внести несколько изменений в файл конфигурации конкретного
клиента в /etc/openvpn/client.conf. Здесь мы устанавливаем адрес сервера OpenVPN,
порт, настроенный на сервере OpenVPN, и фактическое имя сертификата и имена
файлов ключей. Обычно порт OpenVPN - 1194.

### 3. Перезапуск OpenVPN

``service openvpn restart``

### 4. Тестирование подключения к VPN

Теперь пришло время проверить соединение с сервером VPN с машины Debian.
Чтобы гарантировать соединение проведем сначала тест ping с сервером OpenVPN.
Когда он успешно подключится, мы используем следующую команду для подключения.

``sudo openvpn --config /etc/openvpn/server/server.ovpn``

### 5. Автоматизация подключения

Теперь создаём файл

``sudo nano /usr/local/bin/ovpn``

И кладём в него нашу команду запуска:

```
#!/bin/bash

sudo openvpn --config /etc/openvpn/server/server.ovpn
```
После этого даём ему права на запуск:

``sudo chmod +x /usr/local/bin/ovpn``

И мы можем запускать соединение командой

``ovpn``

