**Создание виртуальной машины с cloud-init на примере debian 13**

1. Находим образ по запросу debian cloud images со страницы http://cloud.debian.org/images/cloud/trixie/latest/

Копируем ссылку на образ debian-12-generic-amd64.qcow2 (http://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2)

2. Переходим в терминал OC Proxmox и создаём под root директорию для облачных образов:

```
mkdir cloudinit_images && cd cloudinit_images
```

3. Скачиваем образ диска:

```
wget http://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
```

  Ответ сервера:

```
# wget http://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
--2025-11-12 12:11:04--  http://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
Resolving cloud.debian.org (cloud.debian.org)... 194.71.11.173, 194.71.11.165, 2001:6b0:19::173, ...
Connecting to cloud.debian.org (cloud.debian.org)|194.71.11.173|:80... connected.
HTTP request sent, awaiting response... 302 Found
Location: http://saimei.ftp.acc.umu.se/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2 [following]
--2025-11-12 12:11:04--  http://saimei.ftp.acc.umu.se/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2
Resolving saimei.ftp.acc.umu.se (saimei.ftp.acc.umu.se)... 194.71.11.138, 2001:6b0:19::138
Connecting to saimei.ftp.acc.umu.se (saimei.ftp.acc.umu.se)|194.71.11.138|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 339869696 (324M)
Saving to: ‘debian-13-genericcloud-amd64.qcow2’

debian-13-genericcloud-amd64.qcow2          100%[===========================================================================================>] 324.12M  11.7MB/s    in 30s     

2025-11-12 12:11:35 (10.8 MB/s) - ‘debian-13-genericcloud-amd64.qcow2’ saved [339869696/339869696]
```

4. Создаём шаблон с произвольным именем, например ***tmp-debian-13*** и произвольным id, например, ***2013**

```
qm create 2013 --name tmp-debian-13 --memory 1024 --net0 virtio,bridge=vmbr0
```

5. Импортируем наш скачанный образ в шаблон из локального хранилища:

```
qm importdisk 2013 debian-13-genericcloud-amd64.qcow2 local-lvm
```

Ответ сервера:

```
# qm importdisk 2013 debian-13-genericcloud-amd64.qcow2 local-lvm
importing disk 'debian-13-genericcloud-amd64.qcow2' to VM 2013 ...
  WARNING: You have not turned on protection against thin pools running out of space.
  WARNING: Set activation/thin_pool_autoextend_threshold below 100 to trigger automatic extension of thin pools before they get full.
  Logical volume "vm-2013-disk-0" created.
  WARNING: Sum of all thin volume sizes (473.00 GiB) exceeds the size of thin pool pve/data and the amount of free space in volume group (16.00 GiB).
transferred 0.0 B of 3.0 GiB (0.00%)
transferred 31.0 MiB of 3.0 GiB (1.01%)
transferred 61.7 MiB of 3.0 GiB (2.01%)
transferred 92.8 MiB of 3.0 GiB (3.02%)
transferred 123.5 MiB of 3.0 GiB (4.02%)
<...>
transferred 3.0 GiB of 3.0 GiB (99.70%)
transferred 3.0 GiB of 3.0 GiB (100.00%)
transferred 3.0 GiB of 3.0 GiB (100.00%)
Successfully imported disk as 'unused0:local-lvm:vm-2013-disk-0'
```

6. Сохраняем имя диска, которое высветилось в последней строке импорта

В моём случае из ``unused0:local-lvm:vm-2013-disk-0`` нужно сохранить только ``local-lvm:vm-2013-disk-0``

7. Привязываем диск с образом к виртуальной машине, используя имя диска:

```
qm set 2013 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-2013-disk-0 --ide2 local-lvm:cloudinit --boot c --bootdisk scsi0 --serial0 socket --vga serial0 --agent 1
```

Ответ сервера:

```
# qm set 2013 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-2013-disk-0
update VM 2013: -scsi0 local-lvm:vm-2013-disk-0 -scsihw virtio-scsi-pci
```

8. Монтируем привод с cloudinit:

```
qm set 2013 --ide2 local-lvm:cloudinit
```

   Ответ сервера:
```
# qm set 2013 --ide2 local-lvm:cloudinit
update VM 2013: -ide2 local-lvm:cloudinit
  WARNING: You have not turned on protection against thin pools running out of space.
  WARNING: Set activation/thin_pool_autoextend_threshold below 100 to trigger automatic extension of thin pools before they get full.
  Logical volume "vm-2013-cloudinit" created.
  WARNING: Sum of all thin volume sizes (473.00 GiB) exceeds the size of thin pool pve/data and the amount of free space in volume group (16.00 GiB).
ide2: successfully created disk 'local-lvm:vm-2013-cloudinit,media=cdrom'
```

9. Создаём загрузочный диск для виртуальной машины:

```
qm set 2013 --boot c --bootdisk scsi0
```

Ответ сервера:

```
# qm set 2013 --boot c --bootdisk scsi0
update VM 2013: -boot c -bootdisk scsi0
```

10. Добавляем консоль TTY в виртуальную машину:

```
qm set 2013 --serial0 socket --vga serial0
```

Ответ сервера:

```
# qm set 2013 --serial0 socket --vga serial0
update VM 2013: -serial0 socket -vga serial0
```

11. Добавляем сеть с ip-стеком в качестве dhcp:

```
qm set 2013 --ipconfig0 ip=dhcp
```

Ответ сервера:

```
# qm set 2013 --ipconfig0 ip=dhcp
update VM 2013: -ipconfig0 ip=dhcp
```

12. При необходимости меняем размер диска на нужный нам:

```
qm resize 2013 scsi0 8G
```

Ответ сервера:

```
# qm resize 2013 scsi0 8G
  Size of logical volume pve/vm-2013-disk-0 changed from 3.00 GiB (768 extents) to 8.00 GiB (2048 extents).
  WARNING: You have not turned on protection against thin pools running out of space.
  WARNING: Set activation/thin_pool_autoextend_threshold below 100 to trigger automatic extension of thin pools before they get full.
  Logical volume pve/vm-2013-disk-0 successfully resized.
```

13. Преобразуем готовую виртуальную машину в шаблон:

```
qm template 2013
```

Ответ сервера:

```
# qm template 2013
  Renamed "vm-2013-disk-0" to "base-2013-disk-0" in volume group "pve"
  Logical volume pve/base-2013-disk-0 changed.
  WARNING: Combining activation change with other commands is not advised.
```

Далее шаблон можно клонировать и настраивать его параметры во вкладке cloud-init
