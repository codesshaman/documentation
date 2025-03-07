Шаг 1. Авторизация на сервере:

``ssh user@server_ip``

Шаг 2. бновление списка репозиториев:

``sudo apt update``

Шаг 3. Установка необходимых утилит:

```
sudo apt install curl nano make software-properties-common ca-certificates apt-transport-https -y
```

Шаг 4. Импорт GPG-ключа репозитория docker:

```
wget -O- https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
```

Шаг 5. Добавление репозитория docker:

```
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable"| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Шаг 6. Обновление списка репозиториев:

``sudo apt update``

Шаг 7. Установка docker-ce:

``sudo apt install docker-ce -y``

Шаг 8. Проверка установки:

``docker --version``

Шаг 9. Загрузка docker-compose:

```
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Шаг 10. Права на исполнение файла:

``sudo chmod +x /usr/local/bin/docker-compose``

Шаг 11.Проверка установки:

``docker-compose --version``

 Шаг 12. Клонирование репозитория adcm:

```
git clone https://gitlab.askona.ru/dp-data-platform/adcmpostgres.git
```

``cd adcmpostgres``

Шаг 13. Генерация .env-файла:

``make env``

Шаг 14. Запуск сборки образов:

``make build``

После сборки (когда отработает healthcheck) adcm будет доступен по адресу сервера на порту, указанном в .env-файле. По умолчанию 8000. Если миграции в БД по какой-то причине не прошли, можно вызвать их вручную командой

``make migrate``

Переходим по нужному адресу и наблюдаем запущенный adcm:

``http://127.0.0.1:8000``
