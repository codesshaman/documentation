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
