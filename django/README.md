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

Меняем блок статических файлов

```
# Static files (CSS, JavaScript, Images)
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR / 'static'),
]
```

Сверху, после строки с BASE_DIR, добавляем STATIC_ROOT:

```
STATIC_ROOT = Path(BASE_DIR).joinpath('static')
```


Создаём блок медиафайлов

```
# Media Files
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'
```

Прописываем правильный путь к шаблонам в разделе 'DIRS'

```
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [str(BASE_DIR / 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

Сохраняем файл и выходим.

### Шаг 5. Копируем все статические файлы в нужные папки

``python manage.py collectstatic``

Вывод:

```
125 static files copied to '/project/static'.
```

(цифры и пути могут отличаться)

### Шаг 6. Создание приложений внутри папки apps (на примере парсеров)

``cd apps``

``mkdir parse``

``cd parse``

``django-admin startapp parse44``

``django-admin startapp parse223``

### Шаг 7. Регистрация созданных приложений в файле settings.py

``cd ../../``

``nano project/settings.py``

```
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'apps.parse.parse223.apps.Parse223Config',
    'apps.parse.parse44.apps.Parse44Config'
]
```

### Шаг 8. Правильные настройки имени класса в apps.py приложения:

Меняем ``name`` с ``parse223`` на ``apps.parse.parse223``

Результат:

```
from django.apps import AppConfig


class Parse223Config(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.parser.parse223'
```

Запускаем приложение и проверяем!
