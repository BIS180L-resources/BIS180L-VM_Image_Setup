# AWS_Setup

```
sudo apt-get update
sudo apt-get upgrade
sudo vim /etc/ssh/sshd_config
##Change PasswordAuthentication to yes from no, then save and exit.
sudo /etc/init.d/ssh restart
sudo –i
passwd ubuntu #"Genomics"
sudo apt install xfce4 xfce4-goodies tightvncserver
vncserver #"Genomics"
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
nano ~/.vnc/xstartup
### Paste in
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
###
sudo chmod +x ~/.vnc/xstartup
vncserver
### from new terminal window
ssh -L 5901:127.0.0.1:5901 -N -f -l username server_ip_address #username = ubuntu, password = Genomics, server_ip_address = elastic ip
### in original terminal window
sudo vim ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
## change <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
## to
## <property name="&lt;Super&gt;Tab" type="empty"/>
## Fixes Tab so it autocompletes now
sudo nano /etc/systemd/system/vncserver@.service
### paste
[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=ubuntu
PAMName=login
PIDFile=/home/ubuntu/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
###

vncserver -kill :1
vncserver

## Connected though VNC service now
## Personally using VNC-Viewer-5.3.2

