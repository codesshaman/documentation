#### netstat
``dnf install net-tools``</br>
``netstat -pnltu``</br>
``netstat -pnltu | grep -i "22"``</br>
``netstat -tulpn | grep LISTEN``</br>
#### ss
``ss -lntu``</br>
``ss -lntu -p``</br>
#### nmap
``dnf install nmap``</br>
``nmap -n -PN -sT -sU -p- ВашIP``</br>
#### lsof
``lsof -i``</br>
``lsof -i 80``</br>
