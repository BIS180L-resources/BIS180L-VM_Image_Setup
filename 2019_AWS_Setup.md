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
sudo passwd ubuntu #"Genomics"
sudo apt install xfce4 xfce4-goodies
cd /usr/local/src
sudo wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.9.0.x86_64.tar.gz
sudo tar -xzvf download_file\?file_path\=tigervnc-1.9.0.x86_64.tar.gz
sudo rm download_file\?file_path\=tigervnc-1.9.0.x86_64.tar.gz
cd /usr/local/bin
cp -s ../src/tigervnc-1.9.0.x86_64/usr/bin/* .
cd
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
Description=Start TigerVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu

PIDFile=/home/ubuntu/.vnc/%H:%i.pid
ExecStartPre=-/usr/local/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/local/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/local/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
```

Exit /etc/systemd/system/vncserver@.service and back in terminal

```
sudo systemctl daemon-reload
vncserver -kill :1
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1 # to check
sudo shutdown -r now
```

### Installing Necessary Libraries and Programs

```
sudo -i
apt-get install chromium-browser
apt-get install curl 
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
apt-get install openmpi-bin 
apt-get install libopenmpi-dev
apt-get install ncbi-blast+ 
apt-get install ncbi-blast+-legacy
apt-get install mysql-client 
apt-get install mysql-server #password for root = Genomics
apt-get install libssl-dev
apt-get install libxml2-dev
apt-get install libxslt1-dev
apt-get install texlive-latex-extra 
apt-get install texlive-fonts-recommended
apt-get install dkms
apt-get install liblist-moreutils-perl 
apt-get install libstatistics-descriptive-perl
apt-get install libstatistics-r-perl 
apt-get install perl-doc 
apt-get install libtext-table-perl
apt-get install gdebi-core
apt-get install cmake
```

### Installing latest R

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
apt-get update
apt-get install r-base
apt-get install r-base-dev
```

### Installing Rstudio and make launcher

```
wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb
sudo gdebi rstudio-xenial-1.1.463-amd64.deb
sudo rm rstudio-xenial-1.1.463-amd64.deb
```

### Installing R packages within Rstudio under /home/ubuntu/R/x86_64-pc-linux-gnu-library/3.5 [Default]
```
swirl,ggplot2,genetics,hwde,seqinr,qtl,evaluate,formatR,highr,markdown,yaml,htmltools,caTools,bitops,knitr,rmarkdown,devtools,shiny,pvclust,gplots,cluster,igraph,scatterplot3d,ape,SNPassoc,rsconnect,dplyr,tidyverse
devtools::install_github(repo = "cran/PSMix")
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite(c("Rsubread","snpStats","rtracklayer","goseq","impute","multtest","VariantAnnotation","chopsticks","edgeR"))
install.packages('LDheatmap')
```
