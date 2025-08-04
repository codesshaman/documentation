##### 1. Install from source:

[Download nekoray](https://github.com/Matsuridayo/nekoray/releases)

##### 2. Create script for launch

check $DISPLAY and $XAUTHORITY variables:

```
user@linux:~$ echo $DISPLAY
:1
user@linux:~$ echo $XAUTHORITY
/run/user/1000/gdm/Xauthority
```

create launcher script with this variables:

```
sudo nano /usr/local/bin/run-nekobox-root.sh
```

Paste this code with your variables data:

```
#!/bin/bash
export DISPLAY=:1
export XAUTHORITY=/run/user/1000/gdm/Xauthority
exec pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY PATH=$PATH /opt/nekoray/nekobox -appdata
```

##### 3. Change desktop file:

```
sudo nano /usr/share/applications/nekoray.desktop
```

Comment launch string and run script as launcher:

```
[Desktop Entry]
Name=nekoray
Comment=Qt based cross-platform GUI proxy configuration manager (backend: sing-box)
#Exec=sh -c "PATH=/opt/nekoray:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin /opt/nekoray/nekobox -appdata"
Exec=/usr/local/bin/run-nekobox-root.sh
Icon=/opt/nekoray/nekobox.png
Terminal=false
Type=Application
Categories=Network;Application;
```

Profit! You can launch nekoray as root user!
