For scan all keys from different server:

```
ssh-keyscan <SERVER_IP> >> ~/.ssh/known_hosts
```

If ``known_hosts`` was absent:

```
chmod 644 ~/.ssh/known_hosts
```
