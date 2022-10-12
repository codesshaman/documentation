### Шаг 1. Установка

### Шаг 2: Создание тестового кластера БД:

```
sudo -u postgres /usr/lib/postgresql/14/bin/initdb \
       -D /var/lib/postgresql/14/demo -k -A peer
```

``sudo pg_createcluster 14 demo``

``su postgres``

``/etc/pgbackrest/pgbackrest.conf``

```
[demo]
pg1-path=/var/lib/postgresql/14/demo
```

### Изменение конфига:

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

