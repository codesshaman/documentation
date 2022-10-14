# Смена ip на машине с linux

nano /etc/network/interfaces

iface enp2s0 inet static<br>
  adress 192.168.1.12 # - наш ip<br>
  netmask 225.225.225.0<br>
  gateway 192.168.1.1<br>
  dns-nameservers 8.8.8.8 8.8.4.4<br>
