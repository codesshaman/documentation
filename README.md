# Документация

### Оглавление
+ [Linux](https://github.com/codesshaman/documentation/#Linux "Linux")
  - [Способы открытия файлов](https://github.com/codesshaman/documentation/#Notes "Notes")
  - [Проверить свободные порты](https://github.com/codesshaman/documentation/#Ports "Ports")
  - [Информация о пользователях](https://github.com/codesshaman/documentation/#AboutUsers "AboutUsers")
  - [Терминальные сессии tmux](https://github.com/codesshaman/documentation/#Tmux "Tmux")
  - [Docker](https://github.com/codesshaman/documentation/#Docker "Docker")
    * [Чистый Docker](https://github.com/codesshaman/documentation/#Docker "Docker")
    * [Docker compose](https://github.com/codesshaman/documentation/#Docker-compose "Docker-compose")
    * [Makefile для docker-compose](https://github.com/codesshaman/documentation/#ComposeMakefile "ComposeMakefile")
    * [Docker swarm](https://github.com/codesshaman/documentation/#Docker-swarm "Docker-swarm")
  - [Самоподписные сертификаты mkcert](https://github.com/codesshaman/documentation/#Mkcert "Mkcert")
  - [Логирование](https://github.com/codesshaman/documentation/#Logs "Logs")
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
+ [Инструкции](https://github.com/codesshaman/documentation/#Инструкции "Инструкции")

***

### Linux
> Утиллиты linux

### Notes
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Блокноты, просмотрщики и т.д.



***
### Ports
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Утиллиты для проверки портов

#### netstat
``dnf install net-tools``</br>
``netstat -pnltu``</br>
``netstat -pnltu | grep -i "22"``</br>
``netstat -tulpn | grep LISTEN``</br>
#### ss
``ss -lntu``</br>
``ss -lntu -p``</br>
#### nmap
``dnf install nmap``</br>
``nmap -n -PN -sT -sU -p- ВашIP``</br>
#### lsof
``lsof -i``</br>
``lsof -i 80``</br>
***
### AboutUsers
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Просмотр информации о пользователях и сессиях</br>
``who`` - кто на данный момент находится в системе</br>
``last`` - когда и насколько пользователь заходил в систему</br>
``last`` ***username***  - информация по конкретному пользователю</br>
``lastlog`` - все пользователи с датами последнего входа</br>
***
### Tmux
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Удобное использование терминального пространства при помощи tmux

``tmux new-session -s test`` - создать сессию с названием test</br>
``Ctrl+b %`` - разбить терминал по горизонтали</br>
``Ctrl+b "`` - разбить терминал по вертикали</br>
``Ctrl+b x`` - закрыть окно терминала</br>
``Ctrl+b d`` - отключиться от рабочего терминала</br>
``tmux attach -t test`` - присоединиться к сессии с названием test</br>
``tmux ls`` - список сессий</br>
***
### Docker
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Команды чистого докера

### Docker-compose
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Команды docker-compose

### ComposeMakefile
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Makefile для docker-compose
```
name = docker_configuration
all:
	@printf "Запуск конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d
down:
	@printf "Остановка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml down
re:
	@printf "Пересборка конфигурации ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d --build
clean: down
	@printf "Очистка конфигурации ${name}...\n"
	@docker system prune --a
fclean:
	@printf "Полная очистка всех конфигураций docker\n"
#	@docker stop $$(docker ps -qa)
#	@docker system prune --all --force --volumes
#	@docker network prune --force
#	@docker volume prune --force
.PHONY	: all down re clean fclean
```

### Docker-swarm
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Команды docker в режиме роя

***
### Mkcert
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Получение самоподписного сертификата при помощи mkcert

#### Установка:

``sudo apt install -y wget curl libnss3-tools``<br>
``curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest| grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -``<br>
``mv mkcert-v*-linux-amd64 mkcer``<br>
``chmod a+x mkcert``<br>
``sudo mv mkcert /usr/local/bin/``<br>

#### Проверка:

``mkcert --version``

#### Генерация:

``mkcert localhost``<br>
``mv localhost-key.pem localhost.key``<br>
``mv localhost.pem localhost.crt``<br>
***
### Logs
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Логи linux

Основная папка логов: **/var/log**

Файл лога  |  Назначение
------ | ------
**syslog** | главный системный лог
**auth.log** | все попытки входа на сервер + ip
**dmesg** | лог драйверов
**dpkg.log** | лог менеджера пакетов
**faillog** | лог неудачных попыток входа в систему
+ [Просматривать в блокнотах](https://github.com/codesshaman/documentation/#Notes "Notes")
***
Вы можете создавать свои комбинации!
### Инструкции
+ [Заголовки](https://github.com/AndreyKozhev/Markdown-format#заголовки "Заголовки")
+ [Выделение](https://github.com/AndreyKozhev/Markdown-format#выделение "Выделение")
+ [Списки](https://github.com/AndreyKozhev/Markdown-format#списки "Списки")
+ [Ссылки](https://github.com/AndreyKozhev/Markdown-format#ссылки "Ссылки")
+ [Изображения](https://github.com/AndreyKozhev/Markdown-format#изображения "Изображения")
+ [Блоки кода](https://github.com/AndreyKozhev/Markdown-format#блоки-кода "Блоки кода")
+ [Таблицы](https://github.com/AndreyKozhev/Markdown-format#таблицы "Таблицы")
+ [Цитаты](https://github.com/AndreyKozhev/Markdown-format#цитаты "Цитаты")
+ [Эмодзи](https://github.com/AndreyKozhev/Markdown-format#эмодзи "Эмодзи")
+ [HTML](https://github.com/AndreyKozhev/Markdown-format#html "HTML")
+ [Списки задач](https://github.com/AndreyKozhev/Markdown-format#списки-задач)
+ [Разделительная черта](https://github.com/AndreyKozhev/Markdown-format#%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D0%B8%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F-%D1%87%D0%B5%D1%80%D1%82%D0%B0)
+ [Блоки Примечание и Предупреждение](https://github.com/AndreyKozhev/Markdown-format#%D0%B1%D0%BB%D0%BE%D0%BA%D0%B8-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%87%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%BF%D1%80%D0%B5%D0%B4%D1%83%D0%BF%D1%80%D0%B5%D0%B6%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5 "Блоки Примечание и Предупреждение")
+ [Упоминание человека или организации](https://github.com/AndreyKozhev/Markdown-format#%D1%83%D0%BF%D0%BE%D0%BC%D0%B8%D0%BD%D0%B0%D0%BD%D0%B8%D0%B5-%D1%87%D0%B5%D0%BB%D0%BE%D0%B2%D0%B5%D0%BA%D0%B0-%D0%B8%D0%BB%D0%B8-%D0%BE%D1%80%D0%B3%D0%B0%D0%BD%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8 "Упоминание челове6ка или организации")
