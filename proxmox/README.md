***Создание виртуальной машины с cloud-init на примере debian 12***

1. Находим образ по запросу debian cloud images со страницы http://cloud.debian.org/images/cloud/bookworm/latest/

Копируем ссылку на образ debian-12-generic-amd64.qcow2 (http://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2)

2. Переходим в терминал OC Proxmox и создаём директорию для облачных образов:
   ``mkdir cloudinit_images && cd cloudinit_images``

3. Скачиваем образ диска:

  ``wget http://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2``

4. 
