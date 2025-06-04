### Chand Docker images folder

#### Step 1. Check docker config folder

Check path

```
ls -la /etc/docker
```

and

```
ls -la /etc/docker/daemon.json
```

Create folder or file if has no file/folder

#### Step 2. Edit daemon.json file

```
sudo nano /etc/docker/daemon.json
```

Set your data folder:

```
{
  "data-root": "/data/docker"
}
```

Save and exit
