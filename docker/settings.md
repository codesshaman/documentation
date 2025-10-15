``sudo nano /etc/docker/daemon.json``

```
{
    "log-driver": "json-file",
    "log-opts": {
        "labels-regex": "^.+"
    },
    "bip": "10.31.31.1/24",
    "data-root": "/data/docker",
  "insecure-registries": [
      "registry1.com:5000",
      "registry2.com:5000"
    ],
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
