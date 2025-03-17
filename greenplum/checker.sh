#!/bin/bash

dpkg -l | grep arenadata
dpkg -l | grep postgres
dpkg -l | grep zabbix
dpkg -l | grep adb

systemctl list-units --type=service | grep adcm
systemctl list-units --type=service | grep adb
systemctl list-timers | grep adcm
systemctl list-timers | grep adb

sudo ls /lib/systemd/system/ | grep adcm
sudo ls /lib/systemd/system/ | grep adb

sudo ls -la /data1

sudo ls -la /usr/lib | grep gpdb

sudo ls -la /usr/share/doc | grep gpdb
