### Add Jenkins node

#### 1. Create jenkins-master user for contain jenkins ssh-keys (in master):

```
sudo useradd -m -d /var/lib/jenkins -s /bin/bash jenkins-master
```

```
sudo chown -R jenkins-master:jenkins-master /var/lib/jenkins
```

#### 2. Generate keys and pem (in master):

```
ssh-keygen
```

```
cp id_rsa id_rsa.pem
```

```
ssh-keygen -p -m PEM -f id_rsa.pem
```

#### 3. Add master public key to the node:

##### In master:

```
cat ~/.ssh/id_rsa.pub
```

Copy key and paste to the node authorized_keys

##### In agent node:

Open node and switch to jenkins agent user and:

```
nano ~/.ssh/authorized_keys
```

Past public key and save. Modyfy file if necessary:

```
chmod 600 authorized_keys
```

#### 4. Add public key from agent node to the master node:

##### In agent node:

Copy agent public key:

```
cat ~/.ssh/id_rsa.pub
```

##### In master:

Paste in master:

```
nano ~/.ssh/known_hosts
```

#### 5. Copy PEM key to the jenkins web UI (in master):

```
cat id_rsa.pem
```

Open credentials and past PEM
