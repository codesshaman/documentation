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
