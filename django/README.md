### Основные команды Django

``django-admin startproject main`` - создание проекта

``./manage.py runserver`` - запуск локального сервера

``./manage.py migrate`` - запуск миграций

``./manage.py createsuperuser`` - создать суперпользователя

``./manage.py startapp modulename`` - создание нового модуля

## Создание Django-проекта с правильной архитектурой

### Шаг 1. Создание виртуального окружения

Через терминал:

```
python -m venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

Через Makefile:

```
make venv
source ../venv/bin/activate
make req
pip install --upgrade pip
```

### Шаг 2. Создание директорий

```
mkdir apps
mkdir media
mkdir static
mkdir templates
```
### Шаг 3. Создание проекта (с именем project в данном примере)

Команда:

***django-admin startproject <projectname>***

В нашем примере:

``django-admin startproject project``

 ### Шаг 4. Редактирование settings.py главного проекта

``cd project``

``nano project/settings.py``

