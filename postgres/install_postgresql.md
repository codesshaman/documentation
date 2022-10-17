# Установка на Debian/Ubuntu, настройка удалённого доступа и логгирования

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

```
sudo apt install -y postgresql-14 postgresql-contrib postgresql-client postgresql-common postgresql-client-common postgresql-client-14 libxml2
```

Проверка версии:

``sudo -u postgres psql -c "SELECT version();"``

Проверка статуса службы:

``sudo systemctl status postgresql``

### Шаг 3. Настройка:

```
sudo sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'\n|g" /etc/postgresql/14/main/postgresql.conf
```

``sudo systemctl restart postgresql``

``sudo passwd postgres``

``su postgres``

```
echo "host    all             all             0.0.0.0/0                  md5" >> /etc/postgresql/14/main/pg_hba.conf
echo "hostssl all             all             0.0.0.0/0                  md5" >> /etc/postgresql/14/main/pg_hba.conf
```

``Ctrl+D``

``sudo systemctl restart postgresql``

``sudo systemctl status postgresql``

### Шаг 4. Настройка логгирования:

Создаём скрипт и меняем им настройки логгирования:

``cd ~``

``touch logs_settings.sh``

```
sed -i "s|#logging_collector = off|logging_collector = on\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_rotation_age = 1d|log_rotation_age = 1d\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_rotation_size = 10MB|log_rotation_size = 10MB\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_truncate_on_rotation = off|log_truncate_on_rotation = on\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'|log_filename = postgres-%a.log\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_truncate_on_rotation = off|log_truncate_on_rotation = on\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_connections = off|log_connections = on|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_statement = |log_statement = |g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_min_messages = warning|log_min_messages = warning\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#client_min_messages = notice|client_min_messages = notice\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_min_error_statement = error|log_min_error_statement = error\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#log_min_duration_statement = -1|log_min_duration_statement = 2000\n|g" /etc/postgresql/14/main/postgresql.conf
```

``chmod +x logs_settings.sh``

``sudo ./logs_settings.sh``

Перезапускаем сервис:

``sudo systemctl restart postgresql``

``sudo systemctl status postgresql``

### Шаг 5. Полное удаление:

```
sudo apt remove postgresql-14 postgresql-common postgresql-client-common postgresql-contrib postgresql-client postgresql-client-14 --purge
```

``sudo apt autoremove -y``

### Бонус: Создание тестового кластера БД:

```
sudo -u postgres /usr/lib/postgresql/14/bin/initdb \
       -D /var/lib/postgresql/14/demo -k -A peer
```

``sudo pg_createcluster 14 demo``

Перезагрузка кластера:

``sudo pg_ctlcluster 14 demo start`` или ``sudo systemctl start postgresql@14-demo``

Проверка:

``sudo systemctl status postgresql@14-demo``
