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
cd /usr/local/src
wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz
tar -xzvf download_file\?file_path\=tigervnc-1.9.0.x86_64.tar.gz
rm download_file\?file_path\=tigervnc-1.9.0.x86_64.tar.gz
cd /usr/local/bin
cp -s ../src/tigervnc-1.9.0.x86_64/usr/bin/* .
cd
exit
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

Exit /etc/systemd/system/vncserver@.service and back in terminal

```
sudo systemctl daemon-reload
vncserver -kill :1
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1 # to check
sudo shutdown-r now
```

### Installing Necessary Libraries and Programs

```
sudo -i
apt-get install google-chrome-stable
apt-get install curl libcurl4-openssl-dev #needed for bioconductor
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
apt-get install texlive-latex-extra texlive-fonts-recommended
sudo apt-get install dkms
sudo apt-get install liblist-moreutils-perl libstatistics-descriptive-perl libstatistics-r-perl perl-doc libtext-table-perl
sudo apt-get install gdebi-core
sudo apt-get install cmake
```

### Installing latest R

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
apt-get update
apt-get install r-base
apt-get install r-base-dev
```


```
