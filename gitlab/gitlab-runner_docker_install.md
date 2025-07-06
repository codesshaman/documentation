#### Установка gitlab-runner в docker

```
docker volume create runner1
```

```
sudo mkdir -p /var/log/gitlab-runner
```

```
sudo chown -R 1000:1000 /var/log/gitlab-runner
```

```
docker run -d --name gitlab-runner1 --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v runner1:/etc/gitlab-runner \
    -v /var/log/gitlab-runner:/var/log/gitlab-runner \
    gitlab/gitlab-runner:latest
```
Проверка:

``
docker ps
``

#### Регистрация gitlab-runner в gitlab

```
docker run --rm -it -v runner1:/etc/gitlab-runner gitlab/gitlab-runner:latest register
```
