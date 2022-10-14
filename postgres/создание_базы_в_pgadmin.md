# Создание баз под пользователями postgresql

## Шаг 1. Подключение к серверу

Регистрируем новый сервер в PGAdmin

![подключение к серверу](media/create_db_pgadmin/pgadmin_create_step_0.png)

Вводим название для нашего сервера

![подключение к серверу](media/create_db_pgadmin/pgadmin_create_step_1.png)

Вводим свой ip сервера и порт базы. Логинимся под суперпользователем postgres (пользователь базы, а не пользователь сервера!)

![подключение к серверу](media/create_db_pgadmin/pgadmin_create_step_2.png)

## Шаг 2. Новый пользователь

Создаём нового пользователя

![создание нового пользователя](media/create_db_pgadmin/pgadmin_create_step_3.png)

Задаём имя пользователя

![создание нового пользователя](media/create_db_pgadmin/pgadmin_create_step_4.png)

## Шаг 3. Создание БД

Создаём новую базу данных

![создание новой базы](media/create_db_pgadmin/pgadmin_create_step_5.png)

Назначаем владельцем нашего пользователя

![создание новой базы](media/create_db_pgadmin/pgadmin_create_step_6.png)

## Шаг 4. Создание таблицы

Создаём таблицу чтобы проверить работу системы

![создание новой базы](media/create_db_pgadmin/pgadmin_create_step_7.png)

Выбираем владельцем нужного пользователя

![создание новой базы](media/create_db_pgadmin/pgadmin_create_step_8.png)