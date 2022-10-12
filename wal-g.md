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
