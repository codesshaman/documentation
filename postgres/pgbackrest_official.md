### Шаг 1. Build:

``cd ~``

``mkdir -p /build```

```
wget -q -O - \
       https://github.com/pgbackrest/pgbackrest/archive/release/2.41.tar.gz | \
       tar zx -C /build
```

```
sudo apt-get install make gcc libpq-dev libssl-dev libxml2-dev pkg-config \
       liblz4-dev libzstd-dev libbz2-dev libz-dev libyaml-dev
```

``cd /build/pgbackrest-release-2.41/src && ./configure && make``

### Шаг 2. Установка:

``sudo apt-get install postgresql-client libxml2``

``sudo scp build:/build/pgbackrest-release-2.41/src/pgbackrest /usr/bin``

```
sudo chmod 755 /usr/bin/pgbackrest && \
sudo mkdir -p -m 770 /var/log/pgbackrest && \
sudo chown postgres:postgres /var/log/pgbackrest && \
sudo mkdir -p /etc/pgbackrest && \
sudo mkdir -p /etc/pgbackrest/conf.d && \
sudo touch /etc/pgbackrest/pgbackrest.conf && \
sudo chmod 640 /etc/pgbackrest/pgbackrest.conf && \
sudo chown postgres:postgres /etc/pgbackrest/pgbackrest.conf
```

Check:

``sudo -u postgres pgbackrest``

### Шаг 3: Создание тестового кластера БД:

``su postgres``

```
/usr/lib/postgresql/14/bin/initdb -D /var/lib/postgresql/14/demo -k -A peer
/usr/lib/postgresql/14/bin/pg_ctl -D /var/lib/postgresql/14/main -l logfile start
```

``sudo pg_createcluster 14 demo``

``su postgres``

``/etc/pgbackrest/pgbackrest.conf``

```
[demo]
pg1-path=/var/lib/postgresql/14/demo
```

Проверка:

``pg_ctlcluster 14 demo restart``

``pg_ctlcluster 14 demo status``

### Шаг 4: Настройка архивации:

``su postgres``

```
echo "archive_command = 'pgbackrest --stanza=demo archive-push %p'" > /etc/postgresql/14/demo/postgresql.conf && \
echo "archive_mode = on" >> /etc/postgresql/14/demo/postgresql.conf && \
echo "max_wal_senders = 3" >> /etc/postgresql/14/demo/postgresql.conf && \
echo "wal_level = replica" >> /etc/postgresql/14/demo/postgresql.conf
```

``Ctrl + D``

``sudo pg_ctlcluster 14 demo restart``

``sudo pg_ctlcluster 14 demo status``

### шаг 5: Настройка конфигурации pgbackrest:

Генерация секретного ключа:

``openssl rand -base64 48``

Получившийся ключ вставляем в строку repo1-cipher-pass

``nano /etc/pgbackrest/pgbackrest.conf``

```
# Имя кластера и путь к кластеру:
[demo]
pg1-path=/var/lib/postgresql/14/demo

[global]
# Сгенерированный командой openssl rand -base64 48 ключ
repo1-cipher-pass=zWaf6XtpjIVZC5444yXB+cgFDFl7MxGlgkZSaoPvTGirhPygu4jOKOXf9LO4vjfO
# Тип шифрования
repo1-cipher-type=aes-256-cbc
# Путь к директории с конфигом:
repo1-path=/var/lib/pgbackrest
# Хранить не более 3-х полных копий
repo1-retention-full=3

[global:archive-push]
# Уровень сжатия
compress-level=3
```
