Step 0. Create keys folder (if necessary):

```
sudo mkdir -p /var/lib/jenkins/.ssh && sudo chmod 700 /var/lib/jenkins/.ssh && sudo chown jenkins:jenkins /var/lib/jenkins/.ssh
```

Step 1. Switch to jenkins user

```
sudo su jenkins
```

Step 2. Generate SSH key:

```
ssh-keygen -t ed25519 -f /var/lib/jenkins/.ssh/id_user_servername -C "jenkins->user"
```

!!! where ``user`` is valid remote server username

Step 3. Copy key to the remote server:

```
ssh-copy-id -i /var/lib/jenkins/.ssh/id_user_servername.pub -p 22 user@192.168.1.101
```

Where ``192.168.1.101`` - realy server ip with open 22 ssh port.

Step 4. Get ssh keys with sshscan:

```
ssh-keyscan 192.168.1.101 >> ~/.ssh/known_hosts
```

```
chmod 644 ~/.ssh/known_hosts
```

Step 5. Add private key to jenkins credentials:

```
cat /var/lib/jenkins/.ssh/id_user_servername
```

And paste to manage/credentials/store/system/domain/
