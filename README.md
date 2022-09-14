# Документация

### Оглавление
+ [Linux](https://github.com/codesshaman/documentation/#Linux "Linux")
  - [Проверить свободные порты](https://github.com/codesshaman/documentation/#Ports "Ports")
  - [Терминальные сессии tmux](https://github.com/codesshaman/documentation/#Tmux "Tmux")
  - [Docker](https://github.com/codesshaman/documentation/#Docker "Docker")
    * [Чистый Docker](https://github.com/codesshaman/documentation/#Docker "Docker")
    * [Docker compose](https://github.com/codesshaman/documentation/#Docker-compose "Docker-compose")
    * [Docker swarm](https://github.com/codesshaman/documentation/#Docker-swarm "Docker-swarm")
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
+ [Инструкции](https://github.com/codesshaman/documentation/#Инструкции "Инструкции")

***

### Linux
> Утиллиты linux

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

### Docker-swarm
+ [Оглавление](https://github.com/codesshaman/documentation/#Оглавление "Оглавление")
> Команды docker в режиме роя

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
