## Дать нескольким пользователям права на одну папку:

**sudo groupadd dockertest** - создаём группу
**sudo usermod -aG dockertest user1** - добавляем первого юзера
**sudo usermod -aG dockertest user2** - добавляем второго юзера
**groups user1** - проверяем группы каждого пользователя
**sudo chgrp folder dockertest** - меняем группу папки на нашу
**chmod g+rw folder** - меняем права доступа
**ls -la** - проверяем пользователей группы

## Создать общую папку для разных пользователей:

**sudo mkdir workdir** - создаём в корне рабочую директорию
**sudo chgrp workdir dockertest** - меняем группу папки на нашу
**chmod g+rw folder** - меняем права доступа
**ln -s workdir /home/user/workdir** - создаём символьную ссылку