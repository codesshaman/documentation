### Пример настройки для базы с именем adb:

#### 1. Создание директории (под root)

```
sudo su
```

```
mkdir -p /data1/backup
```

```
chown gpadmin:gpadmin /data1/backup
```

```
chmod 755 /data1/backup
```

#### 2. Первый (полный) бекап (под gpadmin)

```
sudo su gpadmin
```

Сменить ``adb`` на необходимое имя базы данных:

```
gpbackup --dbname adb --backup-dir /data1/backup/
```

Настройки сохраняются в файл вида:

cat backup/gpseg-1/backups/20250512/20250512163716/gpbackup_20250512163716_config.yaml

#### 3. Последующие бекапы (инкрементальные)

Сменить ``adb`` на необходимое имя базы данных:

```
gpbackup --dbname adb --backup-dir /data1/backup --incremental
```
