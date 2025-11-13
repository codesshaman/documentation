Step 0. Create keys folder (if necessary):

```
sudo mkdir -p /var/lib/jenkins/.ssh && sudo chmod 700 /var/lib/jenkins/.ssh && sudo chown jenkins:jenkins /var/lib/jenkins/.ssh
```

Step 1. Set username of remote connection:

```
sudo su jenkins && export SSH_USERNAME="user"
```

where ``user`` is valid remote server username

Step 2. Generate SSH key:

```
sudo -u jenkins env SSH=$SSH_USERNAME ssh-keygen -t ed25519 -f /var/lib/jenkins/.ssh/id_$SSH -C "jenkins->$SSH"
```

Step 3. Copy key to the remote server:

```
sudo -u jenkins ssh-copy-id -i /var/lib/jenkins/.ssh/id_$SSH_USERNAME.pub $SSH_USERNAME@192.168.1.101 -p 22
```

Where ``192.168.1.101`` - realy server ip with open 22 ssh port.
