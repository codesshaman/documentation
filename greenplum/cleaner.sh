#!/bin/bash

sudo pkill -9 -u gpadmin

sudo userdel -r gpadmin

sudo systemctl stop adb-status-checker.timer

sudo systemctl stop adb-status-checker

sudo systemctl disable adb-status-checker

sudo systemctl disable adb-status-checker.timer

sudo systemctl stop adcm-status-checker.timer

sudo systemctl stop adcm-status-checker

sudo systemctl disable adcm-status-checker

sudo systemctl disable adcm-status-checker.timer

sudo rm -rf /lib/systemd/system/adcm-*

sudo ls /lib/systemd/system/ | grep adcm

sudo rm -rf /lib/systemd/system/adb-*

sudo ls /lib/systemd/system/ | grep adb

sudo rm -rf /data1/*

sudo ls -la /data1

sudo apt remove --purge -y postgresql-client postgresql-client-14 postgresql-client-common postgresql-14

dpkg -l | grep arenadata | awk '{print $2}' | xargs sudo apt remove --purge -y

dpkg -l | grep zabbix | awk '{print $2}' | xargs sudo apt remove --purge -y

dpkg -l | grep adb | awk '{print $2}' | xargs sudo apt remove --purge -y

sudo apt autoremove --purge -y

sudo rm -rf /usr/lib/gpdb

sudo rm -rf /usr/share/doc/gpdb

dpkg -l | grep arenadata

dpkg -l | grep postgres

dpkg -l | grep zabbix

dpkg -l | grep adb

echo "Очистка завершена!"
