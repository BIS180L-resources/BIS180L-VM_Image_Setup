# AWS_Setup

## Base Instance Creation
Contents of Base Instance
  1. Free-tier Ubuntu 16.04 LTS AMI
  2. 2 Core, 4 Gb RAM
  3. 30Gb EBS storage
  4. Security, All TCP
  5. Elastic IP (Since been released)

## Updating and installing VNC and Desktop
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
```
Pasted the following into ~/.vnc/xstartup

```
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
```

Exited ~/.vnc/xstartup and now in terminal

```
sudo chmod +x ~/.vnc/xstartup
vncserver
```
From new terminal window

```
ssh -L 5901:127.0.0.1:5901 -N -f -l username server_ip_address #username = ubuntu, password = Genomics, server_ip_address = elastic ip
```

Back in original terminal window

```
sudo vim ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```
change <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
to
<property name="&lt;Super&gt;Tab" type="empty"/>
Fixes Tab so it autocompletes now

Make vnc a system service

```
sudo nano /etc/systemd/system/vncserver@.service
```
Pasted in the following

```
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
```

Exit /etc/systemd/system/vncserver@.service and back in terminal

```
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
vncserver -kill :1
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1 # to check


## Connected though VNC service now
## Personally using VNC-Viewer-5.3.2
## Working in terminal
cd
nano .bashrc ## append 'cd /home/ubuntu' to end of file
sudo -s
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i --force-depends google-chrome-stable_current_amd64.deb
apt-get install -f
### in Applications > Settings > Preferred Applications, set google chrome as browser

###
apt-get install libcurl4-openssl-dev #needed for bioconductor
apt-get install libboost-iostreams-dev
apt-get install libgsl0-dev
apt-get install libmysql++-dev
apt-get install libboost-graph-dev
apt-get install libgl1-mesa-dev #for rgl
apt-get install libglu1-mesa-dev #for rgl
apt-get install libmysqlclient-dev #for R mysql
apt-get install libmpfr-dev
apt-get install libgmp-dev
apt-get install openmpi-bin libopenmpi-dev
apt-get install ncbi-blast+ ncbi-blast+-legacy
apt-get install mysql-client mysql-server #password for root = Genomics
apt-get install libssl-dev
apt-get install libxml2-dev
apt-get install libxslt1-dev
echo 'deb https://cran.cnr.berkeley.edu/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list
apt-get update
apt-get install r-base
apt-get install r-base-dev
apt-get install texlive-latex-extra texlive-fonts-recommended
sudo R

#within R:
install.packages(c("swirl","ggplot2","genetics","hwde","GenABEL","seqinr","qtl")) ##  mirrorCA-1
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("chopsticks")
biocLite("edgeR")
biocLite("VariantAnnotation")
biocLite("snpMatrix")
install.packages("LDheatmap")


sudo apt-get install gdebi-core
