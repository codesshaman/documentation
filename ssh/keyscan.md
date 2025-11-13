For scan all keys from different server:

```
ssh-keyscan 192.168.1.101 >> ~/.ssh/known_hosts
```

If ``known_hosts`` was absent:

```
chmod 644 ~/.ssh/known_hosts
```
