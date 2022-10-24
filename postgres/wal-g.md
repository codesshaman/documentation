### 1. Установка

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

### 2: Изменение конфига кластера:

```
su - postgres -c 'sed -i "s|#wal_level = replica|wal_level = replica\n|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|#archive_mode = off|archive_mode = on\n|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|#max_wal_senders = 10|max_wal_senders = 3\n|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|recovery_target_time|#recovery_target_time|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|recovery_target_time = ''|recovery_target_time = 'notused'|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|archive_command = ''|#archive_command = ''|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|restore_command|#restore_command|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'sed -i "s|#archive_timeout = 0|archive_timeout = 60\n|g" /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'echo "archive_command='"'"'/usr/local/bin/wal-g wal-push \"%p\" >> /var/log/postgresql/archive_command.log 2>&1'"'"'" >> /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'echo "restore_command='"'"'/usr/local/bin/wal-g wal-fetch \"%f\" \"%p\" >> /var/log/postgresql/restore_command.log 2>&1'"'"'" >> /etc/postgresql/14/main/postgresql.conf' && \
su - postgres -c 'echo "#recovery_target_time = '"'"''"'"'" >> /etc/postgresql/14/main/postgresql.conf'
```

``sudo service postgresql restart``

``sudo service postgresql status``

ИЛИ перезагрузить сам кластер:

``sudo pg_ctlcluster 14 main restart``

``sudo pg_ctlcluster 14 main status``

### 3: Создание конфига wal-g:

``su - postgres -c 'nano /var/lib/postgresql/.walg.json'``

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

### 4: Бэкап вручную:

Проверить, что всё готово к бэкапу:

``sudo service postgresql status``

``sudo pg_ctlcluster 14 main status``

Создание бэкапа:

```
su - postgres -c '/usr/local/bin/wal-g backup-push /var/lib/postgresql/14/main'
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
### 5: Бэкап скриптом:

Создаём скрипт:

su - postgres -c 'nano /var/lib/postgresql/.backup.sh'

Код:

```
#!/bin/bash
sudo pg_ctlcluster 14 main start
su - postgres -c '/usr/local/bin/wal-g backup-list --pretty'
su - postgres -c '/usr/local/bin/wal-g backup-push /var/lib/postgresql/14/main'
su - postgres -c '/usr/local/bin/wal-g backup-list --pretty'
```

``su - postgres -c 'chmod 777 /var/lib/postgresql/.backup.sh'``

``sudo bash /var/lib/postgresql/.backup.sh``

# Просмотреть список бэкапов:

Список бэкапов:

``su - postgres -c '/usr/local/bin/wal-g backup-list'``

Список бэкапов в таблице:

``su - postgres -c '/usr/local/bin/wal-g backup-list --pretty'``

Список строкой в формате json:

``su - postgres -c '/usr/local/bin/wal-g backup-list --json'``

Список в развёрнутом json:

``su - postgres -c '/usr/local/bin/wal-g backup-list --pretty --json'``

Детальный список:

``su - postgres -c '/usr/local/bin/wal-g backup-list --detail'``

Детальный список в строке json:

``su - postgres -c '/usr/local/bin/wal-g backup-list --detail --json'``

Детальный список в развёрнутом json:

``su - postgres -c '/usr/local/bin/wal-g backup-list --detail --json --pretty'``

### 6: Расписание бэкапов:

``su - postgres -c 'crontab -e'``

Расписание ежедневных бэкапов в 00:40:

```
40 00 * * * /usr/local/bin/wal-g backup-push /var/lib/postgresql/14/main
```

### 7: Восстановление последнего бэкапа:

``sudo service postgresql stop``

На всякий случай сохраняем оригинал базы:

```
su - postgres -c 'rm -rf /var/lib/postgresql/main && cp -rf  /var/lib/postgresql/14/main  /var/lib/postgresql/'
```

Удаляем базу и восстанавливаем бэкап:

``su - postgres -c 'rm -rf /var/lib/postgresql/14/main'``

``su - postgres -c '/usr/local/bin/wal-g backup-fetch /var/lib/postgresql/14/main LATEST'``

Ответ:

```
INFO: 2022/10/21 11:35:06.272285 base_000000050000000000000018_D_000000050000000000000012 fetched. Upgrading from LSN 18000028 to LSN 1c000028 
INFO: 2022/10/21 11:35:06.272188 Finished decompression of pg_control.tar.br
INFO: 2022/10/21 11:35:06.377325 Finished extraction of part_003.tar.br
INFO: 2022/10/21 11:35:06.377464 Finished decompression of part_003.tar.br
INFO: 2022/10/21 11:35:07.013137 Finished decompression of part_001.tar.br
INFO: 2022/10/21 11:35:07.013248 Finished extraction of part_001.tar.br
INFO: 2022/10/21 11:35:07.060320 Finished decompression of pg_control.tar.br
INFO: 2022/10/21 11:35:07.060349 Finished extraction of pg_control.tar.br
INFO: 2022/10/21 11:35:07.060401 
Backup extraction complete.

```

Обязательно! Создание сигнального файла для восстановления:

``su - postgres -c 'touch /var/lib/postgresql/14/main/recovery.signal'``

Запуск демона:

``sudo service postgresql start``

Проверка:

``sudo service postgresql status``

``sudo pg_ctlcluster 14 main status``

### 8: Восстановление по времени:

Шаг 1. Создаём скрипт для восстановления:

``su - postgres -c 'nano /var/lib/postgresql/.recovery.sh'``

Код:

```
#!/bin/bash
confirm() {
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}
recovery() {
        sudo service postgresql stop
        sleep 5
        sudo service postgresql status
        su - postgres -c 'rm -rf /var/lib/postgresql/main && cp -rf  /var/lib/postgresql/14/main  /var/lib/postgresql/'
        sleep 5
        su - postgres -c 'rm -rf /var/lib/postgresql/14/main'
        su - postgres -c 'wal-g backup-fetch /var/lib/postgresql/14/main LATEST'
        echo "Ожидаю восстановления базы"
        sleep 5
        echo "Запускаю сервис postgres"
        su - postgres -c 'touch /var/lib/postgresql/14/main/recovery.signal'
        sudo service postgresql start
        CHECK_RECOVERY_SIGNAL_ITER=0
        while [ ${CHECK_RECOVERY_SIGNAL_ITER} -le 120 ]
        do
            if [ ! -f "/var/lib/postgresql/14/main/recovery.signal" ]
            then
                echo "Файл recovery.signal удалён"
                break
            fi
            sleep 5
            ((CHECK_RECOVERY_SIGNAL_ITER+1))
        done
        if [ -f "/var/lib/postgresql/12/main/recovery.signal" ]; then
                echo "ОШИБКА: не удалось восстановить базу данных!"
                exit 17
        fi
        echo "Проверка статуса postgres"
        sudo service postgresql status
        sudo pg_ctlcluster 14 main status
}
if confirm "Восстановить последнюю резервную копию? (y/n or enter for no)"; then
        su - postgres -c 'sed -i "/recovery_target_time/d" "/etc/postgresql/14/main/postgresql.conf"'
        recovery
else if confirm "Восстановить более раннюю резервную копию? (y/n or enter for no)"; then
        su - postgres -c 'sed -i "/recovery_target_time/d" "/etc/postgresql/14/main/postgresql.conf"'
        read -p "Сколько дней назад был сделан бэкап? " DAYS
        DATE=$(date -d "-$DAYS days" "+%F %H:%M:%S")
        su - postgres -c "echo \"recovery_target_time = '$DATE'\"  >> /etc/postgresql/14/main/postgresql.conf"
        echo "Запускаю процесс восстановления"
        recovery
   fi
fi
```

``su - postgres -c 'chmod 777 /var/lib/postgresql/.recovery.sh'``

``sudo bash /var/lib/postgresql/.recovery.sh``

### Осторожно! При необходимости - удаление бэкапов из облака:

``su postgres``

Удалить все имеющиеся бэкапы:

```
su - postgres -c '/usr/local/bin/wal-g delete everything --confirm'
```
