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

4. Создаём шаблон с именем ***tmp-debian-13*** и произвольным id, например, ***2013**

   ```
   qm create 2013 --name tmp-debian-13 --memory 1024 --net0 virtio,bridge=vmbr0
   ```

5. Импортируем наш скачанный образ в шаблон из локального хранилища:

   ```
   qm importdisk 2013 debian-13-genericcloud-amd64.qcow2 local-lvm
   ```

6. Сохраняем имя диска, которое высветилось в последней строке импорта

   В моём случае из ``unused0:local-lvm:vm-2013-disk-0`` нужно сохранить только ``local-lvm:vm-2013-disk-0``

7. Привязываем диск с образом к виртуальной машине, используя имя диска:

   ``qm set 2013 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-2013-disk-0``

8. Монтируем привод с cloudinit:

   ``qm set 2013 --ide2 local-lvm:cloudinit``

9. Создаём загрузочный диск для виртуальной машины:

   ``qm set 2013 --boot c --bootdisk scsi0``

10. Добавляем консоль TTY в виртуальную машину:

   ``qm set 2013 --serial0 socket --vga serial0``

11. Добавляем сеть с ip-стеком в качестве dhcp:

   ``qm set 2013 --ipconfig0 ip=dhcp``

12. При необходимости меняем размер диска на нужный нам:

   ``qm resize 2013 scsi0 8G``

13. Преобразуем готовую виртуальную машину в шаблон:

   ``qm template 2013``

Далее шаблон можно клонировать и настраивать его параметры во вкладке cloud-init
