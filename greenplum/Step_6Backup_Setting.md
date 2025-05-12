Пример настройки для базы с именем adb:

```
mkdir -p /data1/backup
```

```
chown gpadmin:gpadmin /data1/backu
```

```
chmod 755 /data1/backup
```

```
gpbackup --dbname adb --backup-dir /data1/backup/
```
