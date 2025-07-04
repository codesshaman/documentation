```
wget http://ftp.de.debian.org/debian/pool/main/g/gitlab-ci-multi-runner/gitlab-runner_14.10.1-1_amd64.deb
```

```
sudo dpkg -i gitlab-runner_14.10.1-1_amd64.deb
```

```
mkdir ~/.gitlab-runner
```

```
nano ~/.gitlab-runner/config.toml
```

Content:

```
concurrent = 1
check_interval = 0

[[runners]]
  name = "Your Gitlab Runner Name"
  url = "https://gitlab.your_website.ru"
  token = "your_access_token"
  executor = "shell"
  [runners.custom_build_dir]
  [runners.cache]

```


```
sudo nano /etc/systemd/system/gitlab-runner-user.service
```

Content:

```
[Unit]
Description=GitLab Runner (User Mode)
After=network.target

[Service]
User=user
WorkingDirectory=/home/user
ExecStart=/usr/bin/gitlab-runner run
Restart=always

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
```

```
sudo systemctl enable --now gitlab-runner-user
```

```
sudo systemctl status gitlab-runner-user
```
