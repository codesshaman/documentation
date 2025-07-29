#### Client side

```
ssh-keygen -t ed25519 -f ~/.ssh/xui_tunnel_key
```

```
cat ~/.ssh/xui_tunnel_key.pub
```

Copy key

#### Server side

```
sudo su
```

```
adduser tunneluser --disabled-password --gecos ""
```

```
nano /etc/ssh/sshd_config
```

Allow login for user:

```
AllowUsers tunneluser <my_server_user> <another_user>
```

```
systemctl reload ssh
```

```
su tunneluser && cd ~
```

```
mkdir -p ~/.ssh
```

```
chmod 700 ~/.ssh
```

```
touch ~/.ssh/authorized_keys
```

```
chmod 600 ~/.ssh/authorized_keys
```

```
chown -R tunneluser:tunneluser ~/.ssh
```

```
nano ~/.ssh/authorized_keys
```

Past ssh key from client and save

#### Check connection from client:

```
ssh -i ~/.ssh/xui_tunnel_key -o IdentitiesOnly=yes tunneluser@my_ip
```

#### Start VPN tunnel connection:

12345 - client side port

56789 - server side port

```
ssh -N -L 12345:127.0.0.1:56789 tunneluser@my_ip -i ~/.ssh/xui_tunnel_key
```

All done! We can open GUI in localhost:

```
http://localhost:12345/w3N0n1nNn/panel/
```
