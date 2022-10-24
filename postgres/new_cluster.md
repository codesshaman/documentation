# Создание тестового кластера БД

```
sudo -u postgres /usr/lib/postgresql/14/bin/initdb \
       -D /var/lib/postgresql/14/demo -k -A peer
```

``sudo pg_createcluster 14 demo``

Перезагрузка кластера:

```
sudo pg_ctlcluster 14 demo start или sudo systemctl start postgresql@14-demo
```

Проверка:

``sudo systemctl status postgresql@14-demo``

# Удаление тестового кластера БД

Список кластеров:

``su - postgres -c 'ls /var/lib/postgresql/14'``

``sudo pg_ctlcluster 14 demo stop``

Удаление БД:

``su - postgres -c 'rm -rf /var/lib/postgresql/14/demo'``
