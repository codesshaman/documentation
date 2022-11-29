# Документация по Kubernetes

### Автодополенения

``source <(kubectl completion bash)``

Минимальные абстракции

###Pods (Поды)

Под - минимальный набор контейнеров приложения.

Минимальный .yaml для пода:

```
---
apiVersion: v1        # версия api
kind: Pod             # тип - под
metadata:             # секция метаданных
  name: test-pod-12   # уникальное имя объекта
  labels:             # поле меток
    app: test-app     # имя метки
spec:                 # спецификации
  containers:         # секция контейнеров
    - image: nginx:1.12 # образ контейнера
      name: nginx     # имя контейнера
      ports:          # список портов
       - containerPort: 80  # порт для открытия
```

Просмотреть текущие поды:

``kubectl get pods``

Запуск пода из файла:

``kubectl create -f pod.yml``

###ReplicaSet (РепликаСеты)

Репликасет - набор реплик подов. Репликасет управляет количеством запущенных подов. Поды выбираются по лейблу (метке). Репликасет управляет набором подов с соответствующей меткой.

Минимальный .yaml для репликасета:

```
---
apiVersion: apps/v1         # версия api
kind: ReplicaSet            # тип сущности
metadata:                   # поле метаданных
  name: my-replicaset       # уникальное имя объекта
spec:                       # спецификация
  replicas: 5               # количество реплик
  selector:                 # селектор реплик
    matchLabels:            # селектор по меткам
      app: test-app         # имя метки
  template:                 # шаблон
    metadata:               # метаданные
      labels:               # метки
        app: test-app       # имя метки
    spec:                   # спецификация
      containers:           # контейнеры
        - image: nginx:1.13 # образ контейнера
          name: nginx       # имя контейнера
          ports:            # список портов
            - containerPort: 80 # открытый порт
```

Просмотреть текущие репликасеты:

``kubectl get rs``
