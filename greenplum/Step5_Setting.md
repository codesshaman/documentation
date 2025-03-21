Входим под пользователем gpadmin:

```
sudo su gpadmin
```

2. Правим файл .bashrc

```
nano ~/.bashrc
```

Добавляем в конец файла строки

```
export PATH=/usr/lib/gpdb/bin/:$PATH
source /usr/lib/gpdb/greenplum_path.sh
MASTER_DATA_DIRECTORY=/data1/master/gpseg-1
export COORDINATOR_DATA_DIRECTORY=/data1/master/gpseg-1
```

Сохраняем файл.

3. Выгружаем данные из .bashrc

```
source ~/.bashrc
```

4. Проверяем статус кластера:

```
gpstate -s
```

5. Входим в psql:

```
psql -p 5432 -d adb
```

6. Чтобы убедится что всё работает выводим список всех баз:

```
\l
```

7. Добавляем все необходимые данные в pg_hba под root:

```
sudo nano /data1/master/gpseg-1/pg_hba.conf
```

8. Перезапуск greenplum под gpadmin:

```
sudo su gpadmin
gpstop
gpstart
gpstate -s
```
