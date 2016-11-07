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
cd /usr/src
wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.7.0.x86_64.tar.gz
tar xvf download_file?file_path=tigervnc-1.7.0.x86_64.tar.gz
rm download_file?file_path=tigervnc-1.7.0.x86_64.tar.gz
cd /usr/bin
cp -s ../src/tigervnc-1.7.0.x86_64/usr/bin/* .
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
From new terminal window

```
ssh -L 5901:127.0.0.1:5901 -N -f -l ubuntu 52.52.160.9 #password = Genomics
```

Back in original terminal window

```
sudo vim ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```

change 

```
<property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
```

to

```
<property name="&lt;Super&gt;Tab" type="empty"/>

```
Fixes Tab so it autocompletes now

Make vnc a system service

```
sudo nano /etc/systemd/system/vncserver@.service
```
Pasted in the following

```
[Unit]
Description=Start TigerVNC server at startup
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
vncserver -kill :1
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1 # to check
```

## Installing Applications now
### Working inside VNC
### Personally using VNC-Viewer-5.3.2
## Working in terminal

### Changing directory terminal opens into

```
nano .bashrc 
## append 'cd /home/ubuntu' to end of file
```

### Installing Google Chrome

```sudo 
cd
sudo -s
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i --force-depends google-chrome-stable_current_amd64.deb
apt-get install -f
### in Applications > Settings > Preferred Applications, set google chrome as browser
```

### Installing Necessary Libraries and Programs

```
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
echo 'deb https://cran.cnr.berkeley.edu/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list
apt-get update
apt-get install r-base
apt-get install r-base-dev
```

### Installing Packages inside R

```
sudo R
install.packages(c("swirl","ggplot2","genetics","hwde","GenABEL","seqinr","qtl")) ##  mirror CA-1
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("chopsticks")
biocLite("edgeR")
biocLite("VariantAnnotation")
biocLite("snpMatrix")
install.packages("LDheatmap")
```

### Installing Rstudio-server
Created a Desktop Launcher

```
wget https://download2.rstudio.org/rstudio-server-1.0.44-amd64.deb
sudo gdebi rstudio-server-1.0.44-amd64.deb
```

### Installing libre office 

```
sudo apt-get install libreoffice-writer
```

### Installing htop

```
sudo apt-get install htop
```

### Installing igv
#### Also created a desktop launcher

```
sudo apt-get igv
```

### Installing Jalview

```
sudo apt-get install jalview
```

### Installing Others

```
sudo apt-get install seaview
sudo apt-get install clustalw clustalx kalign t-coffee muscle mafft probcons
```

### Installing Short Read Tools
#### Note no cufflinks

```
sudo apt-get install tophat bwa bowtie2 bowtie2-examples samtools bedtools fastqc
```

### Installing Blast

```
apt-get install blast2 ncbi-blast+ ncbi-blast+-legacy
```

### Markdown viewer: Remarkable
Downloaded from website and installed with gdebi

### Installing PIP

```
sudo apt-get install python-pip python-numpy python-scipy
```

### Installing MACS2

```
sudo pip install MACS2
```

### Installing Cytoscape
Downloaded from their website

```
sudo chmod 755 Cytoscape_3_4_0_unix.sh
sudo ./Cytoscape_3_4_0_unix.sh
```
Installed to default

### Installing Gedit

```
sudo apt-get install gedit gir1.2-gtksource-3.0
```

### Installing Emboss

```
sudo apt-get install emboss
```

### Install Mega
Downloaded from website and installed wih gdebi

### Placing Class Data
Downloaded and unpacked KorfData.tar.gz into /data

### Installing additional R packages

```
sudo R
install.packages(c("evaluate","formatR","highr","markdown", "yaml","htmltools","caTools","bitops","knitr","rmarkdown"))
install.packages("devtools")
install.packages("shiny")
devtools::install_github("rstudio/shinyapps")
devtools::install_github(repo = "cran/PSMix")
install.packages(c("pvclust","gplots","cluster","igraph","scatterplot3d","ape","SNPassoc"))
source("http://bioconductor.org/biocLite.R")
biocLite(c("Rsubread","rtracklayer","goseq","impute","multtest","VariantAnnotation"))
```

### Installing FreeBayes

```
cd /usr/local/src
git clone --recursive git://github.com/ekg/freebayes.git
cd freebayes
make
sudo make install
```

### Installing GATK 3.6
Downloaded from website

```
cd /usr/local/src
mkdir GenomeAnalysisTK
mv ~/GenomeAnalysisTK-3.4-46.tar.bz2 /usr/local/src/GenomeAnalysisTK
cd GenomeAnalysisTK
bunzip2 GenomeAnalysisTK-3.6.tar.bz2
tar -xvf GenomeAnalysisTK-3.6.tar
cd /usr/local/bin
### created sh called GenomeAnalysisTK with chmod 755 
### allows GenomeAnalysisTK to be invoked without including "java -jar /path/to/GenomeAnalysisTK.jar"
```
