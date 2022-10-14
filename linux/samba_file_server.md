# Файловый сервер samba установка

> Запускать под root

## Шаг 1. Установка samba server

```apt update```

```apt install -y samba samba-client```

### Бэкап конфигурации

```cp /etc/samba/smb.conf /etc/samba/smb.conf_default```

## Шаг 2. Создание пользователя и роли

```adduser smbserv```

```mkdir /home/smbserv/smb```

```chown nobody:nogroup /home/smbserv/smb```

```chmod a-w /home/smbserv/smb```

```mkdir /home/smbserv/smb/files```

```chown smbserv:smbserv /home/smbserv/smb/files```

```mkdir /home/smbserv/smb/files/samba```

```mkdir /home/smbserv/smb/files/samba/public```

```chmod -R 0755 /home/smbserv/smb/files/samba/public```

```mkdir /home/smbserv/smb/files/private```

```groupadd smbgrp```

```usermod -aG smbgrp smbserv```

```chgrp smbgrp /home/smbserv/smb/files/samba/private```

```smbpasswd -a smbserv```

## Шаг 3. Редактирование конфигурации

```nano /etc/samba/smb.conf```

### Конфигурация:

```
[global]
workgroup = WORKGROUP
security = user
map to guest = bad user
wins support = no
dns proxy = no
server role = standalone server
[public]
path = /media/samba/public
guest ok = yes
force user = nobody
browsable = yes
writable = yes
create mask = 777
[private]
path = /media/samba/private
valid users = @smbgrp
guest ok = no
browsable = yes
writable = yes
```

### Проверка изменений

```testparm -s```

### Перезапуск демона samba

```service smbd restart```

## Шаг 4. Открытие необходимых портов

```iptables -A INPUT -p tcp -m tcp --dport 445 -s 10.0.0.0/24 -j ACCEPT```

```iptables -A INPUT -p tcp -m tcp --dport 139 -s 10.0.0.0/24 -j ACCEPT```

```iptables -A INPUT -p udp -m udp --dport 137 -s 10.0.0.0/24 -j ACCEPT```

```iptables -A INPUT -p udp -m udp --dport 138 -s 10.0.0.0/24 -j ACCEPT```

### Проверка открытых портов

```iptables -L```
