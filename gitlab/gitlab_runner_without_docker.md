```
wget http://ftp.de.debian.org/debian/pool/main/g/gitlab-ci-multi-runner/gitlab-runner_14.10.1-1_amd64.deb
```

```
sudo dpkg -i gitlab-runner_14.10.1-1_amd64.deb
```

```
sudo touch /var/log/gitlab-runner.log
```

```
sudo chown user:user /var/log/gitlab-runner.log
```

```
sudo touch /var/run/gitlab-runner.pid
```

```
sudo chown user:user /var/run/gitlab-runner.pid
```

```
sudo nano ~/.start-gitlab-runner.sh
```

Content:

```
#!/bin/bash

LOG_FILE="/var/log/gitlab-runner.log"
PID_FILE="/var/run/gitlab-runner.pid"

mkdir -p "$(dirname "$LOG_FILE")" /var/run

nohup gitlab-runner run >> "$LOG_FILE" 2>&1 &

echo $! > "$PID_FILE"

echo "GitLab Runner запущен в фоне (PID: $(cat "$PID_FILE")). Логи: $LOG_FILE"
```

```
chmod +x .start-gitlab-runner.sh
```

```
sudo nano /etc/systemd/system/gitlab-runner-user.service
```

Content:

```
[Unit]
Description=GitLab Runner (User-Mode via Script)
After=network.target

[Service]
User=user
ExecStart=/home/user/.start-gitlab-runner.sh
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
