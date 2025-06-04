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

#### Step 4. Apply export (in the Data Server)

```
sudo exportfs -a
```
#### Step 5. If necessary allow connection in the firewall (in the Data Server)

```
sudo ufw allow from 192.168.10.0/24 to any port nfsAdd commentMore actions
```

#### Step 6. Install NFS-client (in the Web Server)

```
sudo apt update && sudo apt install nfs-common
```

#### Step 7. Create mount point (in the Web Server)

```
sudo mkdir -p /home/user/remote_folders
```

#### Step 8. Mount remote folder (in the Web Server)

```
sudo mount 192.168.10.131:/home/user/remote_data /home/user/remote_folders
```

#### Step 9. Edit FSTAB (in the Web Server)

```
sudo nano /etc/fstab
```
Add the string:

```
192.168.10.131:/home/user/remote_data /home/user/remote_folders nfs defaults 0 0
```

#### Step 10. Create necessary simlinks (in the Web Server)

```
ln -s /home/user/remote_folders/data ~/project/data
```
