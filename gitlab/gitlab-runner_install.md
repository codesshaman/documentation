#### Установка gitlab-runner в docker

```docker volume create runner1```

```
docker run -d --name gitlab-runner1 --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v runner1:/etc/gitlab-runner \
    gitlab/gitlab-runner:latest
```
Проверка:

``docker ps``

#### Регистрация gitlab-runner в gitlab

```
docker run --rm -it -v runner1:/etc/gitlab-runner gitlab/gitlab-runner:latest register
```

