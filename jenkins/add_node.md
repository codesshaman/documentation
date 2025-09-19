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

#### 2/ 
