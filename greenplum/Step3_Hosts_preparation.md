1. Даём root-права пользователю user:

```
sudo nano /etc/sudoers.d/user
```

Вставляем туда следующую строку:

```
user    ALL=(ALL) NOPASSWD:ALL
```

Сохраняем, выходим.

2. Закомментируем репозитории zabbix во избежании глюков:

```
sudo nano /etc/apt/sources.list.d/zabbix.list
```

Комментируем, сохраняем, выходим, обновляем список репозиториев.

3. Обновляем список репозиториев, устанавливаем необходимые пакеты:

```
sudo apt update && \
sudo apt install -y && \
mc \
zip \
curl \
nano \
make \
ncdu \
htop \
ldap-utils \
ca-certificates \
postgresql-client \
apt-transport-https \
postgresql-client-common \
software-properties-common
```

4. Установим node exporter:

```
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz

tar xvfz node_exporter-*.linux-amd64.tar.gz
 
cd node_exporter-*.*-amd64
 
sudo cp node_exporter /usr/bin
 
sudo useradd -r -M -s /bin/false node_exporter
 
sudo chown node_exporter:node_exporter /usr/bin/node_exporter
```

Создадим демона для node exporter:

```
sudo nano /etc/systemd/system/node_exporter.service
```

Со следующим содержимым:

```
[Unit]
Description=Prometheus Node Exporter
 
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/bin/node_exporter
 
[Install]
WantedBy=multi-user.target
```

Теперь обновляем список сервисов:

```
sudo systemctl daemon-reload
```

И включаем демона в автзагрузку:

```
sudo systemctl enable --now node_exporter
```

Проверяем статус сервиса:

```
sudo systemctl status node_exporter
```

5. Подключим репозитории:

Импортируем GPG-ключи репозиториев:

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D913219AB5333005
sudo apt update
```

6. Изменение контрольных групп хостов.

Для развёртывания ADB GreenPlum необходимо подготовить все хосты, на которых будет развёрнута БД.

Необходимо перевести хосты с cgroups v2 на cgroups v1.

Проверяем директорию cgroups:

```
ls /sys/fs/cgroup
```

Мы должны увидеть следующую картину, характерную для cgroups v2:

```
:~$ ls /sys/fs/cgroup
cgroup.controllers      cgroup.threads         dev-mqueue.mount  io.stat                        sys-fs-fuse-connections.mount
cgroup.max.depth        cpu.pressure           init.scope        memory.numa_stat               sys-kernel-config.mount
cgroup.max.descendants  cpuset.cpus.effective  io.cost.model     memory.pressure                sys-kernel-debug.mount
cgroup.procs            cpuset.mems.effective  io.cost.qos       memory.stat                    sys-kernel-tracing.mount
cgroup.stat             cpu.stat               io.pressure       misc.capacity                  system.slice
cgroup.subtree_control  dev-hugepages.mount    io.prio.class     proc-sys-fs-binfmt_misc.mount  user.slice
```

Открываем файл загрузчика в редакторе:

```
sudo nano /etc/default/grub
```

Меняем GRUB_CMDLINE_LINUX_DEFAULT, добавив нужный нам параметр приведём строку к виду:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash systemd.unified_cgroup_hierarchy=0"
```

Сохраняем файл и обновляем конфигурацию загрузчика:

```
sudo update-grub
```

А теперь перезагружаем машину:

```
sudo reboot
```

После перезагрузки снова смотрим директорию cgroups.

```
ls /sys/fs/cgroup
```

Она должна поменяться, папок с файлами должно стать значительно меньше:

```
:~$ ls /sys/fs/cgroup
blkio  cpuacct      cpuset   freezer  memory  net_cls           net_prio    pids  systemd
cpu    cpu,cpuacct  devices  hugetlb  misc    net_cls,net_prio  perf_event  rdma  unified
```

Это означает, что мы успешно перешли на правильную версию control groups в нашей системе.

7. Установка cron.

В современных версиях Linux cron установлен по умолчанию. Но бывают урезанные дистрибутивы где есть systemd.timer, но нет cron. Следующая команда проверит это и если что вернёт cron в систему:

```
sudo apt install cron
```

8. Изменение локали


Проверяем свою локаль командой 

```
locale
```

Вывод должен быть следующим:

```
LANG=en_US.UTF-8
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=
```

Если же локаль отличается от en_US.UTF-8, необходимо изменить локаль. Для этого устанавливаем пакет locales:

```
sudo apt install locales
```

Далее отредактируем файл конфигурации локалей:

```
sudo nano /etc/locale.gen
```

Необходимо раскомментировать ``en_US.UTF-8 UTF-8`` и убедиться что все остальные локали закомментированы:

```
<...>
# en_PH.UTF-8 UTF-8
# en_SC.UTF-8 UTF-8
# en_SG ISO-8859-1
# en_SG.UTF-8 UTF-8
# en_US ISO-8859-1
# en_US.ISO-8859-15 ISO-8859-15
en_US.UTF-8 UTF-8
# en_ZA ISO-8859-1
# en_ZA.UTF-8 UTF-8
# en_ZM UTF-8
# en_ZW ISO-8859-1
# en_ZW.UTF-8 UTF-8
# eo UTF-8
<...>
```
Сохраняем файл и генерируем новую локаль:

```
sudo locale-gen
```

Теперь отредактируем файл, содержащий локаль по умолчанию:

```
sudo nano /etc/default/locale
```

Заменяем локаль после знака равенства на необходимый нам ``en_US.UTF-8``

Обновим так же и переменную окружения:

```
export LANG=en_US.UTF-8
```

И после этого можем перезапускать сервер:

```
sudo reboot
```

Следующая проверка локали должна выдать необходимый нам результат.

9. Удаляем ufw

Файервол может помешать установке, потому удаляем его по крайней мере на время этапа установки:

```
sudo apt purge ufw -y
```

10. Меняем настройки ssh: 

Отредактируем конфиг ssh для возможности входа под root:

```
sudo nano /etc/ssh/sshd_config
```

Наша задача раскомментировать и изменить строку

```
PermitRootLogin yes
```

Сохраняем файл, выходим.

Перезапускаем демона:

```
sudo systemctl restart ssh
```

11. Задаём пароль root-пользователю:

```
sudo passwd root
```

Повторить данные действия на всех хостах, где будет установлен ADB: Master, Standby, Segment  - серверах.
