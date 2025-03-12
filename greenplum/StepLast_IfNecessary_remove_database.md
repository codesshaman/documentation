#### Для удаления БД в случае сбоя при установки или невозможности обновления версии

1. Узнаём pid процессов, запущенных под пользователем:

``ps -u gpadmin``

Ответ:

```
user@Master:~$ ps -u gpadmin
    PID TTY          TIME CMD
 184950 ?        08:01:41 postgres
 184951 ?        00:04:10 postgres
```

2. Убиваем процессы пользователя:

``sudo kill -9 <process_id>``

Ответ:

```
user@Master:~$ sudo kill -9 184950
user@Master:~$ ps -u gpadmin
    PID TTY          TIME CMD
```

3. Удаляем пользователя вместе с домашней директорией:

```
sudo userdel -r gpadmin
```

4. Останавливаем сервсиы, связанные с ADB:

```
sudo systemctl stop adb-status-checker
sudo systemctl disable adb-status-checker
sudo systemctl stop adcm-status-checker
sudo systemctl disable adcm-status-checker
```

5. Удаляем сервисы и проверяем удаление

```
sudo rm -rf /lib/systemd/system/adcm-*
sudo ls /lib/systemd/system/ | grep adcm
sudo rm -rf /lib/systemd/system/adb-*
sudo ls /lib/systemd/system/ | grep adb
```

6. Удаляем всё из каталога данных /data1:

```
sudo rm -rf /data1/*
sudo ls -la /data1
```

7. Перезапукаем ноду:

```
sudo reboot
```

8. После перезагрузки проверяем что всё удалилось:

```
systemctl list-units --type=service | grep adcm
systemctl list-units --type=service | grep adb
sudo ls /lib/systemd/system/ | grep adcm
sudo ls /lib/systemd/system/ | grep adb
sudo ls -la /data1
```

Повторяем действия на всех хостах кластера.
