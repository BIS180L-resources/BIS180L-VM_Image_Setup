# Notes and procedure on creating instance
**Need to work in N. Virginia**

# AWS_Setup

## Base Instance Creation
Contents of Base Instance
  1. Free-tier Ubuntu 18.04 LTS AMI
  2. 2 Core, 4 Gb RAM
  3. 30Gb EBS storage
  4. Security, All TCP
  5. Elastic IP (Since been released)

sudo apt-get update
sudo apt-get upgrade
sudo nano /etc/ssh/sshd_config
##Change PasswordAuthentication to yes from no, then save and exit.
sudo /etc/init.d/ssh restart
sudo passwd ubuntu #"Genomics"
sudo apt install xfce4 xfce4-goodies libssl-dev
cd /usr/local/src
sudo wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.10.1.x86_64.tar.gz
sudo tar -xzvf download_file\?file_path\=tigervnc-1.10.1.x86_64.tar.gz
sudo rm download_file\?file_path\=tigervnc-1.10.1.x86_64.tar.gz
cd /usr/local/bin
sudo cp -s ../src/tigervnc-1.10.1.x86_64/usr/bin/* .
vncserver #Genomics
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
nano ~/.vnc/xstartup
```
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
```

Exited ~/.vnc/xstartup and now in terminal

```
sudo chmod +x ~/.vnc/xstartup
vncserver
sudo nano ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```

change 

```
<property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
```

to

```
<property name="&lt;Super&gt;Tab" type="empty"/>

```

Exit to terminal

```
sudo nano /etc/systemd/system/vncserver@.service
```

Add

```
[Unit]
Description=Start Tiger vncserver at startup
After=syslog.target network.target

[Service]
Type=forking
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu

PIDFile=/home/ubuntu/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
```

Exit /etc/systemd/system/vncserver@.service and back in terminal
Edit config file to include encryption and other settings

```
cd .vnc
myIP=$(hostname --ip-address)
openssl req -x509 -newkey rsa -days 365 -nodes -config /usr/lib/ssl/openssl.cnf -keyout vnc-server-private.pem -out vnc-server.pem -subj '/CN=${myIP}' -addext 'subjectAltName=IP:${myIP}'
nano config
```
Add
```
SecurityTypes=tlsvnc,X509Vnc
X509Cert=/home/ubuntu/.vnc/vnc-server.pem
X509Key=/home/ubuntu/.vnc/vnc-server-private.pem
depth=24
geometry=1280x800
```


```
sudo systemctl daemon-reload
vncserver -kill :1
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1 # to check
```
Copy `vnc-server.pem` to own computer

```
sudo shutdown -r now
```
