  Измените файл pg_hba.conf. Файл pg_hba.conf также находится в каталоге data вашего сервера PostgreSQL.
  В этом файле определяются правила доступа пользователей к базам данных.
  Вам нужно добавить новую запись, позволяющую доступ с вашего нового IP-адреса.
  Запись должна содержать IP-адрес, подсеть, имя базы данных, имя пользователя и метод аутентификации.

``nano /etc/postgresql/14/main/pg_hba.conf``

Добавить в конец:

```
host    all             all             95.105.65.119/24        md5
```

Сохранить файл и перезапустить службу:

``sudo systemctl restart postgresql``

Проверка:

``sudo systemctl status postgresql``

Статус:

```
● postgresql.service - PostgreSQL RDBMS
     Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled)
     Active: active (exited) since Mon 2023-07-10 11:13:17 MSK; 1s ago
    Process: 1638 ExecStart=/bin/true (code=exited, status=0/SUCCESS)
   Main PID: 1638 (code=exited, status=0/SUCCESS)
        CPU: 1ms

Jul 10 11:13:17 dbserv systemd[1]: Starting PostgreSQL RDBMS...
Jul 10 11:13:17 dbserv systemd[1]: Finished PostgreSQL RDBMS.
```
