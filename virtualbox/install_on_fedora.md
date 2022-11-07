# Установка на fedora

### 1. Установить репозиторий VirtualBox в Fedora:

``cd /etc/yum.repos.d/``

``sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo``

``sudo nano /etc/yum.repos.d/virtualbox.repo``

Заменить Fedora 35 на нужную версию Fedora.

### 2. Обновить пакеты.

``sudo dnf update``

### 3. Убедиться, что используется последняя доступная версия ядра:

``sudo rpm -qa kernel |sort -V |tail -n 1``

``uname -r````

Вывод этих команд должен совпадать, иначе перезагружаемся в свежее ядро:

``sudo reboot``

### 4. Установить необходимые зависимости для сборки:

```
sudo dnf install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms qt5-qtx11extras libxkbcommon
```

### 5. Установить VirtualBox:

``sudo dnf install VirtualBox-6.0``

### 6. Пересобрать модули ядра:

``/usr/lib/virtualbox/vboxdrv.sh setup``

### 7. Добавить текущего пользователя в группу vboxusers:

``usermod -a -G vboxusers user_name``
