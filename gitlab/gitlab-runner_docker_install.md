#### Установка gitlab-runner в docker

```docker volume create runner1```

```sudo touch /var/log/gitlab-runner.log```

```
docker run -d --name gitlab-runner1 --restart unless-stopped \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v runner1:/etc/gitlab-runner \
  -v /var/log/gitlab-runner.log:/var/log/gitlab-runner/gitlab-runner.log \
  gitlab/gitlab-runner:latest
```
Проверка:

``docker ps``

#### Регистрация gitlab-runner в gitlab

```
docker run --rm -it -v runner1:/etc/gitlab-runner gitlab/gitlab-runner:latest register
```
