# Установка на Debian

### Шаг 1. Проверка доступных версий в репозитории:

``sudo apt-cache search postgresql | grep postgresql``

Если нет нужной версии, добавляем репозиторий с нужными версиями:

```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
```

Импортируем GPG-ключ для данного репозитория:

```
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

### Шаг 2. Установка:

Обновляем списки репозиториев:

``sudo apt -y update``

Установка всех необходимых пакетов:

``sudo apt install -y postgresql-14 postgresql-contrib postgresql-contrib-14 postgresql-client-14 postgresql-server-dev-14``

Проверка версии:

``sudo -u postgres psql -c "SELECT version();"``

Проверка статуса службы:

``sudo systemctl status postgresql``

### Шаг 3. Настройка:

```
sudo sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'\n|g" /etc/postgresql/14/main/postgresql.conf
```

``sudo systemctl restart postgresql``

``su postgres``

```
sudo echo "host    all             all             0.0.0.0/0                  md5" >> /etc/postgresql/14/main/pg_hba.conf
```

``Ctrl+D``

``sudo systemctl restart postgresql``

``sudo systemctl status postgresql``

### Шаг 4. Настройка логгирования:

Меняем настройки логгирования:

``su postgres``

```
echo 'sed -i "s|#logging_collector = off|logging_collector = on\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_rotation_age = 1d|log_rotation_age = 1d\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_rotation_size = 10MB|log_rotation_size = 10MB\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_truncate_on_rotation = off|log_truncate_on_rotation = on\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'|log_filename = postgres-%a.log\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_truncate_on_rotation = off|log_truncate_on_rotation = on\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_connections = off|log_connections = on|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_statement = |log_statement = |g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_min_messages = warning|log_min_messages = warning\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#client_min_messages = notice|client_min_messages = notice\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_min_error_statement = error|log_min_error_statement = error\n|g" /etc/postgresql/14/main/postgresql.conf'; && \
echo 'sed -i "s|#log_min_duration_statement = -1|log_min_duration_statement = 2000\n|g" /etc/postgresql/14/main/postgresql.conf';
```

Перезапускаем сервис:

``Ctrl+D``

``sudo systemctl restart postgresql``

``sudo systemctl status postgresql``

### Смена пароля пользователя БД (при необходимости):

``su postgres``

``psql postgres``

```
ALTER USER "postgres" WITH PASSWORD 'new_password';
```

### Полное удаление (при необходимости):

```
sudo apt purge postgresql-14 postgresql-contrib postgresql-client libxml2
```

```
sudo rm -rf /var/log/postgresql /etc/postgresql /etc/init.d/postgresql /var/lib/postgresql /var/cache/postgresql /run/postgresql /usr/include/postgresql /usr/share/postgresql
```
