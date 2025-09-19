### Add Jenkins node

#### 1. Create jenkins-master user for contain jenkins ssh-keys:

```
sudo useradd -m -d /var/lib/jenkins -s /bin/bash jenkins-master
```

```
sudo chown -R jenkins-master:jenkins-master /var/lib/jenkins
```

```
ssh-keygen
```

#### 2. Add master public key to the node:

```
cat ~/.ssh/id_rsa.pub
```

Copy key and paste to the node authorized_keys

Open node and switch to jenkins agent user and:

```
nano ~/.ssh/authorized_keys
```

Past public key and save. Modyfy file:

```
chmod 600 authorized_keys
```

#### 3. Copy public key to the jenkins web UI:

Open credentials and past public key
