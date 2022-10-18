### Шаг 1. Установка

``cd ~/downloads``

```
curl -L "https://github.com/wal-g/wal-g/releases/download/v0.2.15/wal-g.linux-amd64.tar.gz" -o "wal-g.linux-amd64.tar.gz"
```

``tar -xzf wal-g.linux-amd64.tar.gz``

``rm wal-g.linux-amd64.tar.gz``

``sudo mv wal-g /usr/local/bin/``

``sudo chown postgres:postgres /usr/local/bin/wal-g``

Проверка:

``wal-g --version``

### Шаг 3: Изменение конфига кластера:

``su postgres``

```
sed -i "s|#wal_level = replica|wal_level = replica\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#archive_mode = off|archive_mode = on\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#max_wal_senders = 10|max_wal_senders = 3\n|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|archive_command|#archive_command|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|restore_command|#restore_command|g" /etc/postgresql/14/main/postgresql.conf && \
sed -i "s|#archive_timeout = 0|archive_timeout = 60\n|g" /etc/postgresql/14/main/postgresql.conf && \
echo "archive_command='/usr/local/bin/wal-g wal-push \"%p\" >> /var/log/postgresql/archive_command.log 2>&1' " >> /etc/postgresql/14/main/postgresql.conf && \
echo "restore_command='/usr/local/bin/wal-g wal-fetch \"%f\" \"%p\" >> /var/log/postgresql/restore_command.log 2>&1' " >> /etc/postgresql/14/main/postgresql.conf
```

``Ctrl + D``

``sudo service postgresql restart``

``sudo service postgresql status``

ИЛИ перезагрузить сам кластер:

``sudo pg_ctlcluster 14 main restart``

``sudo pg_ctlcluster 14 main status``

### Шаг 4: Создание конфига wal-g:

``su postgres``

``cd ~``

``nano .walg.json``

Код:

```
{
"WALG_S3_PREFIX": "s3://yourbucketname",
"AWS_ACCESS_KEY_ID": "yourkey",
"AWS_SECRET_ACCESS_KEY": "yoursecretkey",
"AWS_ENDPOINT": "http://hb.bizmrg.com",
"AWS_REGION": "ru-msk",
"WALG_COMPRESSION_METHOD": "brotli",
"WALG_DELTA_MAX_STEPS": "5",
"PGDATA": "/var/lib/postgresql/14/main",
"PGHOST": "/var/run/postgresql/.s.PGSQL.5432"
}
```

Примеры более развёрнутых настроек:

```
{
"WALG_S3_PREFIX": "s3://yourbucketname",
"AWS_ACCESS_KEY_ID": "yourkey",
"AWS_SECRET_ACCESS_KEY": "yoursecretkey",
"AWS_ENDPOINT": "http://hb.bizmrg.com",
"AWS_REGION": "ru-msk",
"WALG_COMPRESSION_METHOD": "brotli",
"WALG_DELTA_MAX_STEPS": "5",
"PGDATA": "/var/lib/postgresql/14/main",
"PGHOST": "/var/run/postgresql/.s.PGSQL.5432"
"AWS_S3_FORCE_PATH_STYLE": "true",
"WALG_UPLOAD_CONCURRENCY": "2",
"WALG_DOWNLOAD_CONCURRENCY": "2",
"WALG_UPLOAD_DISK_CONCURRENCY": "2",
"WALG_DELTA_MAX_STEPS": "7"
}
```

``chown postgres:postgres /var/lib/postgresql/.walg.json``

### Шаг 5: Бэкап:

``su postgres``

```
wal-g backup-push /var/lib/postgresql/14/main
```

Ответ:

```
INFO: 2022/10/13 14:10:30.453187 Delta backup from base_00000001000000000000000B_D_000000010000000000000009 with LSN b000028. 
INFO: 2022/10/13 14:10:30.471958 Calling pg_start_backup()
INFO: 2022/10/13 14:10:30.578881 Walking ...
INFO: 2022/10/13 14:10:30.579263 Starting part 1 ...
INFO: 2022/10/13 14:10:30.796326 Finished writing part 1.
INFO: 2022/10/13 14:10:30.938200 Starting part 2 ...
INFO: 2022/10/13 14:10:30.938288 /global/pg_control
INFO: 2022/10/13 14:10:30.939531 Finished writing part 2.
INFO: 2022/10/13 14:10:30.940654 Calling pg_stop_backup()
INFO: 2022/10/13 14:10:32.019141 Starting part 3 ...
INFO: 2022/10/13 14:10:32.019321 backup_label
INFO: 2022/10/13 14:10:32.019344 tablespace_map
INFO: 2022/10/13 14:10:32.019899 Finished writing part 3.
INFO: 2022/10/13 14:10:32.346216 Wrote backup with name base_00000001000000000000000D_D_00000001000000000000000B
```

# Просмотреть список бэкапов:

Список бэкапов:

``wal-g backup-list``

Список бэкапов в таблице:

``wal-g backup-list --pretty``

Список строкой в формате json:

``wal-g backup-list --json``

Список в развёрнутом json:

``wal-g backup-list --pretty --json``

Детальный список:

``wal-g backup-list --detail``

Детальный список в строке json:

``wal-g backup-list --detail --json``

Детальный список в развёрнутом json:

``wal-g backup-list --detail --json --pretty``

### Шаг 6: Расписание бэкапов:

``su postgres``

``crontab -e``

Расписание ежедневных бэкапов в 00:40:

```
40 00 * * * wal-g backup-push /var/lib/postgresql/14/main
```

### Шаг 7: Восстановление:

``sudo service postgresql stop``

``su postgres``

``wal-g backup-fetch /var/lib/postgresql/14/main LATEST``

``touch /var/lib/postgresql/14/main/recovery.signal``

``exit`` или ``Ctrl + D``

``sudo service postgresql start``

### Шаг 8: (При необходимости) удаление бэкапов из облака:

``su postgres``

Удалить все имеющиеся бэкапы:

```
wal-g delete everything --confirm
```
