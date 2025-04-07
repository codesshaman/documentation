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
export MASTER_DATA_DIRECTORY=/data1/master/gpseg-1
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

8. Увеличиваем MTU сетевых соединений для возможностей обработки больших массивов данных:

```
sudo nano /etc/netplan/00-installer-config.yaml
```
Добавляем в интерфейс ``bond0`` строку ``mtu: 9000``:

```
network:
  bonds:
    bond0:
      addresses:
      - 10.0.12.34/24
      interfaces:
      - enp152s0f0np0
      - enp152s0f1np1
      - enp75s0f0np0
      - enp75s0f1np1
      nameservers:
        addresses:
        - 192.168.1.4
        - 192.168.1.216
        search:
        - hcaskona.com
      parameters:
        lacp-rate: slow
        mode: 802.3ad
        transmit-hash-policy: layer2
      routes:
      - to: default
        via: 10.0.12.33
      mtu: 9000                      # <- добавленная строка
  ethernets:
    enp152s0f0np0: {}
    enp152s0f1np1: {}
    enp75s0f0np0: {}
    enp75s0f1np1: {}
  version: 2
```

8. Перезапуск greenplum под gpadmin:

```
sudo su gpadmin
gpstop
gpstart
gpstate -s
```
