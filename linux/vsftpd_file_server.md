# Установка

> Все действия выполняются под суперпользователем

### Шаг 1. Установка vsftpd

```apt update```

```apt install vsftpd```

```service vsftpd status```

### Шаг 2. Конфигурация firewall

```ufw allow 20/tcp```

```ufw allow 21/tcp```

```ufw allow 40000:50000/tcp```

```ufw allow 990/tcp```

```ufw allow openssh```

```ufw enable```

```ufw status```

### Шаг 3. Создание пользователя и директорий

```adduser ftpd```

```mkdir /home/ftpd/ftp```

```chown nobody:nogroup /home/ftpd/ftp```

```chmod a-w /home/ftpd/ftp```

```mkdir /home/ftpd/ftp/files```

```chown ftpd:ftpd /home/ftpd/ftp/files```

### Шаг 4. Редактирование конфига

```cp /etc/vsftpd.conf /etc/vsftpd.conf_default```

```nano /etc/vsftpd.conf```

### Новая конфигурация:

```
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
force_dot_files=YES
pasv_min_port=40000
pasv_max_port=50000

user_sub_token=$USER
local_root=/home/$USER/ftp

ssl_enable=YES
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH
```

### Шаг 5. Создание сертификата

```openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem```

### Шаг 6. Перезагрузка демона

```systemctl restart vsftpd.service```

```systemctl status vsftpd.service```


