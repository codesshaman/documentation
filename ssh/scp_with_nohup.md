#### requirements

``src`` - source server
``dest`` - destination server

## 1. Source server preparation

### Step 1. Switch to root

Switch to root in the source server

```
sudo -i
```
or
```
sudo su - root
```

### Step 2. Generate key without password

```
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

### Step 3. Send key to the destination server

```
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@dest
```

### Step 4. Check nopass login

```
ssh -i ~/.ssh/id_ed25519 user@dest
```

### Step 5. Start copy with nohup

```
nohup scp -r /path/to/data user@dest:/path/to/target/ > scp.log 2>&1 &
```

Check:

```
tail -f scp.log
```
