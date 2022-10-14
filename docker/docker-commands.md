# Список полезных команд Docker

## Команды docker

**docker version** - информация о docker

**docker ps** - просмотр запущенных контейнеров

**docker ps -a** - просмотр всех контейнеров

**docker images** - просмотр локальных образов

## Подкоманды Docker

**docker build** - Собрать образ Docker

**docker run** - Запустить образ Docker в качестве контейнера

**docker commit** - Сохранить контейнер Docker в качестве образа

**docker tag** - Присвоить тег образу Docker

## Развёртывание образа

**docker images** - список образов

**docker build** . - создание образа из каталога с Dockerfile

**docker build . -t containername:0.0.1** - создание образа с именем и версией

**sudo docker-compose up -d --build** - создание образа, сборка и запуск в фоне

## Команды запуска контейнеров

**docker run imagename** - создаёт контейнер из образа и выполняет его

**docker run -d imagename** - создаёт контейнер, работающий в фоне

**docker run -d -p 10002:80 --name containername** - запуск с пробросом чтобы избежать конфликта портов

## Стратегии перезапуска

**no** - не перезапускать при выходе из контейнера

**always** - всегда перезапускать при выходе из контейнера

**unless-stopped** - всегда перезагружать, за исключением команды остановки

**on-failure[:max-retry]** - перезапускать только в случае сбоя

## Сети Docker

**docker network create my_network** - создание сети my_network

**docker network connect my_network container_1** - подключение container_1 к my_network

**docker run -it --network my_network ubuntu:16.04 bash** - запуск нового контейнера в сети my_network

## Mapping портов

Mapping портов осуществляется при создании контейнера из образа.

**docker run -p 8080:80 imagename** - внешний:внутренний порты контейнера

## Подключение к контейнеру

**docker exec -it containerid bash** - подключение к bash работающего контейнера

**docker attach conainerid** - подключение к рабочему контейнеру

**docker run -it imagename** - создание + подключение по sh

**docker run -it imagename bash** - создание + подключение по bash

**docker run -it imagename zsh** - создание + подключение по zsh

## Информация о контейнере

**docker logs -f conteinerid** - вывод логов контейнера

**docker container inspect conteinerid** - вывод всей информации о контейнере

**docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -q)** - вывод IP

**docker port conteinerid** - публичные порты контейнера

**docker top conteinerid** - процессы контейнера

**docker ps -q | xargs** - вывод id контейнеров

**docker stats --no-stream** - статистика использования ресурсов контейнерами

## Отладка контейнеров

**docker run --rm -it imagename sh** - подключение в режиме отладки

## Команды остановки контейнеров

**docker stop conainerid** - остановка контейнера

**docker restart conainerid** - перезапуск контейнера

**docker pause conainerid** - приостановка контейнера

**docker unpause conainerid** - возобновление контейнера

**docker kill conainerid** - сигнал завершения для контейнера

**sudo docker-compose down** - остановка контейнеров

## Удаление контейнеров

**docker rm imagename** - удаляет остановленный контейнер

**docker container prune** - удаление все остановленные контейнер

**docker system prune -a** - удаление всеx контейнеров и образов
