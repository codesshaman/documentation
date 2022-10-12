### Шаг 1. Установка

```
cd ~/downloads
curl -L "https://github.com/wal-g/wal-g/releases/download/v0.2.15/wal-g.linux-amd64.tar.gz" -o "wal-g.linux-amd64.tar.gz"
tar -xzf wal-g.linux-amd64.tar.gz
rm wal-g.linux-amd64.tar.gz
sudo mv wal-g /usr/local/bin/
```

Проверка:

``wal-g --version``

### Шаг 2: Создание тестового кластера БД:

```
sudo -u postgres /usr/lib/postgresql/14/bin/initdb \
       -D /var/lib/postgresql/14/demo -k -A peer
```

``sudo pg_createcluster 14 demo``

``su postgres``

``nano /etc/pgbackrest/pgbackrest.conf``

Код:

```
[demo]
pg1-path=/var/lib/postgresql/14/demo
```

### Изменение конфига кластера:

``su postgres``

```
sed -i "s|#wal_level = replica|wal_level = replica\n|g" /etc/postgresql/14/demo/postgresql.conf && \
sed -i "s|#archive_mode = off|archive_mode = on\n|g" /etc/postgresql/14/demo/postgresql.conf && \
sed -i "s|archive_command|#archive_command|g" /etc/postgresql/14/demo/postgresql.conf && \
sed -i "s|restore_command|#restore_command|g" /etc/postgresql/14/demo/postgresql.conf && \
sed -i "s|#archive_timeout = 0|archive_timeout = 60\n|g" /etc/postgresql/14/demo/postgresql.conf && \
echo "archive_command='/usr/local/bin/wal-g wal-push \"%p\" >> /var/log/postgresql/archive_command.log 2>&1' " >> /etc/postgresql/14/demo/postgresql.conf && \
echo "restore_command='/usr/local/bin/wal-g wal-fetch \"%f\" \"%p\" >> /var/log/postgresql/restore_command.log 2>&1' " >> /etc/postgresql/14/demo/postgresql.conf
```

Перезагрузка конфига:

``Ctrl + D``

``sudo killall -s HUP postgres``

### Создание конфига wal-g:

``su postgres``

``cd ~``

``nano .walg.json``

Код:

```
{
"WALG_S3_PREFIX": "s3://yourbucket/postgresbackups",
"AWS_ACCESS_KEY_ID": "yourkey",
"AWS_SECRET_ACCESS_KEY": "yoursecretkey",
"WALG_COMPRESSION_METHOD": "brotli",
"WALG_DELTA_MAX_STEPS": "5",
"PGDATA": "/var/lib/postgresql/14/demo",
"PGHOST": "/var/run/postgresql/.s.PGSQL.5432"
}
```

``chown postgres:postgres /var/lib/postgresql/.walg.json``

```
