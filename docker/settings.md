``sudo nano /etc/docker/daemon.json``

```
{
    "log-driver": "json-file",
    "log-opts": {
        "labels-regex": "^.+"
    },
    "registry-mirrors": [
        "https://mirror.gcr.io",
        "https://daocloud.io",
        "https://c.163.com/",
        "https://registry.docker-cn.com",
        "https://dockerhub.timeweb.cloud"
    ]
}
```

``sudo systemctl daemon-reload``

``sudo service docker restart``

``sudo service docker status``
