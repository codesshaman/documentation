### Setting up remote folder with ssh

Destination - Data Server
Work Machine - Web Server

#### Step 1. Generate ssh key In Web Server

```
ssh-keygen -t rsa
```

```
ssh-copy-id user@remote_server_ip
```

#### Step 2. Install sshfs

```
sudo apt update && sudo apt install sshfs
```

#### Step 3. Create mount point (in the Data Server)

```
mkdir /home/user/remote_data
```

#### Step 4. Mount data folder (in the Web Server)

```
mkdir /home/user/remote_folders
```

```
sshfs user@remote_server_ip:/home/user/remote_data /home/user/remote_folders
```
