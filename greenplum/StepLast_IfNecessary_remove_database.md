#### Для удаления БД в случае сбоя при установки или невозможности обновления версии

1. Узнаём pid процессов, запущенных под пользователем:

```
ps -u gpadmin
```

2. Убиваем процессы пользователя, если они есть:

```
sudo pkill -9 -u gpadmin
```

3. Удаляем пользователя вместе с домашней директорией:

```
sudo userdel -r gpadmin
```

4. Останавливаем сервсиы, связанные с ADB:

```
sudo systemctl stop adb-status-checker.timer
```
```
sudo systemctl stop adb-status-checker
```
```
sudo systemctl disable adb-status-checker
```
```
sudo systemctl disable adb-status-checker.timer
```
```
sudo systemctl stop adcm-status-checker.timer
```
```
sudo systemctl stop adcm-status-checker
```
```
sudo systemctl disable adcm-status-checker
```
```
sudo systemctl disable adcm-status-checker.timer
```

5. Удаляем сервисы и проверяем удаление

```
sudo rm -rf /lib/systemd/system/adcm-*
```
```
sudo ls /lib/systemd/system/ | grep adcm
```
```
sudo rm -rf /lib/systemd/system/adb-*
```
```
sudo ls /lib/systemd/system/ | grep adb
```

6. Удаляем всё из каталога данных /data1:

```
sudo rm -rf /data1/*
```
```
sudo ls -la /data1
```

7. Удаляем postgres:

```
sudo apt remove --purge -y postgresql-client postgresql-client-14 postgresql-client-common postgresql-14
```

```
sudo apt autoremove --purge -y
```

```
sudo rm -rf /usr/lib/gpdb
```

```
sudo rm -rf /usr/share/doc/gpdb
```

Проверяем:

```
dpkg -l | grep postgres
```

Перезапукаем ноду:

```
sudo reboot
```

8. После перезагрузки проверяем что всё удалилось:

```
systemctl list-units --type=service | grep adcm
```
```
systemctl list-units --type=service | grep adb
```
```
systemctl list-timers | grep adcm
```
```
systemctl list-timers | grep adb
```
```
sudo ls /lib/systemd/system/ | grep adcm
```
```
sudo ls /lib/systemd/system/ | grep adb
```
```
sudo ls -la /data1
```

Повторяем действия на всех хостах кластера.
