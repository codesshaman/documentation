## Docker Registry 

### Into the Registry Server

##### Step 1. Install docker

Install docker and docker-compose on the server

##### Step 2. Clone registry repo to the registry server:

```
git clone https://github.com/codesshaman/docker_registry.git && cd docker_registry
```

##### Step 3. Create .env file:

```
make env && nano .env
```

Change variables and pathes

##### Step 4. Create local network:

```
make net
```

##### Step 5. Create or load certificates:

```
make certs
```

Or copy your certificate and key to the ``./certs`` folder.

You need write cert and ket name to the ``REGISTRY_CERT`` and ``REGISTRY_KEY`` variables.

##### Step 6. Build configuration:

```
make build
```

Check: ``http://your_server_ip:8080``
(8080 or ``REGUI_PORT`` value)

### Into the Pull Client Server

##### Step 1. Install docker

Install docker on the server

##### Step 2. Change hosts file

```
sudo nano /etc/hosts
```

add string

```
192.168.100.1:5000  my_registry.loc
```

``192.168.100.1`` - Registry Server IP

``my_registry.loc`` - registry server domain (domain with certificates)

##### Step 3. Change docker daemon:

```
sudo nano /etc/docker/daemon.json
```

Add string:

```
{
  "insecure-registries": ["my_registry.loc:5000"]
}
```

##### Step 4. Create directory for certificate

```
sudo mkdir -p /etc/docker/certs.d/my_registry.loc:5000
```

##### Step 5. Copy certifcate

Copy certificate to the Pull Client Server

```
scp my_registry.loc.crt user@client:/tmp/
```

```
sudo cp /tmp/my_registry.loc.crt /etc/docker/certs.d/my_registry.loc:5000/ca.crt
```

```
sudo chmod 644 /etc/docker/certs.d/my_registry.loc:5000/ca.crt
```

##### Step 6. Restart docker

```
sudo systemctl restart docker
```

##### Step 7. Check

```
docker pull alpine
```

```
docker tag alpine my_registry.loc:5000/alpine
```

```
docker push my_registry.loc:5000/alpine
```

If ``docker push`` is work — all settings is correct.

You can pull from this repo:

```
docker pull <registry-host>:<port>/<repository>/<image>:<tag>
```

example:

```
docker pull my_registry.loc:5000/alpine:latest
```

