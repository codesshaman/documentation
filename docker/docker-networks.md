# Сети Docker

**docker network create my_network** - создание сети my_network
**docker network connect my_network container_1** - подключение container_1 к my_network
**docker run -it --network my_network ubuntu:16.04 bash** - запуск нового контейнера в сети my_network