# Создание тестового кластера БД

```
sudo -u postgres /usr/lib/postgresql/14/bin/initdb \
       -D /var/lib/postgresql/14/demo -k -A peer
```

``sudo pg_createcluster 14 demo``

Перезагрузка кластера:

```
sudo pg_ctlcluster 14 demo start или sudo systemctl start postgresql@15-demo
```

Проверка:

``sudo systemctl status postgresql@14-demo``
