``
sudo nano /etc/docker/daemon.json
``


```
{
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  },
  "default-runtime": "nvidia",
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
