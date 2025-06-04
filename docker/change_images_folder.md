### Chand Docker images folder

#### Step 0. Stop docker

```
sudo systemctl stop docker
```

#### Step 1. Check docker config folder

Check path

```
sudo ls -la /etc/docker
```

and

```
sudo ls -la /etc/docker/daemon.json
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

#### Step 3. Check daemon.json file configuration

```
sudo dockerd --config-file /etc/docker/daemon.json
```

#### Step 4. Copy old images data to the new folder (if necessary):

```
sudo rsync -aP /var/lib/docker/ /data/docker/
```

#### Step 5. Start docker

```
sudo systemctl start docker
```

#### Step 6. Check configuration:

```
docker info | grep "Docker Root Dir"
```

Expected answer:

Docker Root Dir: /data/docker
