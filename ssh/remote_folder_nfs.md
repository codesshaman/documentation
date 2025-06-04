### Setting up remote folder with ssh

Destination - Data Server (192.168.10.131)
Work Machine - Web Server (192.168.10.129)


#### Step 1. Install NFS-server (in the Data Server)

```
sudo apt update && sudo apt install nfs-kernel-server
```

#### Step 2. Create mount point (in the Data Server)

```
mkdir /home/user/remote_data
```
```
sudo chown nobody:nogroup /home/user/remote_data
```
```
sudo chmod 777 /home/user/remote_data
```

#### Step 3. Setting config (in the Data Server)

Open config

```
sudo nano /etc/exports
```

Add access for all subnet:

```
/home/user/remote_data 192.168.10.0/24(rw,sync,no_subtree_check)
```

#### Step 4. Create necessary symlinks (in the Data Server)

```
ln -s ~/remote_folders/data ~/my_project/data
```

#### Step 5. Apply export (in the Data Server)

```
sudo exportfs -a
```

#### Step 6. If necessary allow connection in the firewall (in the Data Server)

```
sudo ufw allow from 192.168.10.0/24 to any port nfs

```

#### Step 5. Edit fstab for automaticly access (in the Web Server)

```
nano /etc/fstab
```

add string:

```
sshfs#user@remote_server_ip:/home/user/remote_data /home/user/remote_folders fuse defaults,_netdev,IdentityFile=/home/user/.ssh/id_rsa,allow_other 0 0
```
