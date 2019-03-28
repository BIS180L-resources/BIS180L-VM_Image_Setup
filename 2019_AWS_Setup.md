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
sudo apt-get install cython
apt-get install gedit gir1.2-gtksource-3.0
apt-get install emboss
apt install default-jdk
apt install openjdk-8-jdk
apt-get install ruby-dev nodejs
apt-get install python-pip python-numpy python-scipy
pip install --upgrade pip
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

### Installing libre office 

```
sudo apt-get install libreoffice-writer libreoffice-calc
```

### Installing git viewer

```
sudo apt-get install gitg
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


### Installing BWA

```
cd /usr/local/src
sudo git clone https://github.com/lh3/bwa.git
cd bwa; sudo make
cd /usr/local/bin
sudo ln -s /usr/local/src/bwa/bwa
```

### Installing Bowtie

```
cd /usr/local/src
sudo wget https://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.1.2/bowtie-1.1.2-linux-x86_64.zip
unzip bowtie-1.1.2-linux-x86_64.zip
cd /usr/local/bin
sudo ln -sf ../src/bowtie-1.1.2/bowtie .

```

### Installing Bowtie2

```
cd /usr/local/src
wget sudo wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.5/bowtie2-2.3.5-linux-x86_64.zip
sudo unzip bowtie2-2.3.5-linux-x86_64.zip
cd /usr/local/bin
sudo cp -sf ../src/bowtie2-2.3.5-linux-x86_64/bowtie2 .
```

### Installing Tophat

```
cd /usr/local/src
sudo wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz
sudo tar xvfz tophat-2.1.1.Linux_x86_64.tar.gz
cd /usr/local/bin
sudo ln -s ../src/tophat-2.1.1.Linux_x86_64/tophat .
```

### Installing Samtools

```
cd /usr/local/src
sudo wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
sudo tar xvfj samtools-1.9.tar.bz2
cd samtools-1.9
sudo ./configure --prefix=/usr/local/src/samtools-1.9
sudo make
sudo make install
cd /usr/local/bin
sudo cp -s ../src/samtools-1.9/bin/samtools .
```

### Installing Bedtools2

```
cd /usr/local/src
sudo wget https://github.com/arq5x/bedtools2/releases/download/v2.28.0/bedtools-2.28.0.tar.gz
sudo tar -zxvf bedtools-2.28.0.tar.gz
cd bedtools2
sudo make
cd /usr/local/bin
sudo cp -s /usr/local/src/bedtools2/bin/* .
```

### Installing Fastqc

```
cd /usr/local/src
sudo wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip
sudo unzip fastqc_v0.11.8.zip
cd FastQC/
sudo chmod 0755 fastqc
cd /usr/local/bin
sudo cp -s ../src/FastQC/fastqc .
```

### Installing Cufflinks

```
cd /usr/local/src
sudo wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
sudo tar -xvzf cufflinks-2.2.1.Linux_x86_64.tar.gz
cd /usr/local/bin
sudo cp -sf ../src/cufflinks-2.2.1.Linux_x86_64/cuff* .
sudo cp -sf ../src/cufflinks-2.2.1.Linux_x86_64/g* .
```

### Markdown viewer: Remarkable

```
sudo wget https://remarkableapp.github.io/files/remarkable_1.87_all.deb
sudo gdebi remarkable_1.87_all.deb
```

### Installing MACS2

```
sudo pip install MACS2
```

### Installing Cytoscape

```
cd /usr/local/src
sudo wget https://github.com/cytoscape/cytoscape/releases/download/3.7.1/Cytoscape_3_7_1_unix.sh
sudo chmod 755 Cytoscape_3_7_1_unix.sh
sudo ./Cytoscape_3_7_1_unix.sh
```

### Installing FreeBayes

```
cd /usr/local/src
sudo git clone --recursive git://github.com/ekg/freebayes.git
cd freebayes
sudo make
sudo make install
```

### Installing GATK 4.1.0.0

```
cd /usr/local/src
sudo wget https://github.com/broadinstitute/gatk/releases/download/4.1.0.0/gatk-4.1.0.0.zip
sudo unzip gatk-4.1.0.0.zip
cd /usr/local/bin
sudo ln -s /usr/local/src/gatk-4.1.0.0/gatk .
```

### Installing Atom

```
sudo wget https://atom.io/download/deb
sudo mv deb atom.deb
sudo gdebi atom.deb
```

Add atom packages:

* git-control
* markdown-pdf
* line-ending-converter
* language-markdown
* Sublime-Style-Column-Selection

### Installing fish

```
sudo apt-get install fish
```

then

```
sudo vi /etc/passwd
```

And change the line for default shell to /usr/bin/fish, i.e.

```
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/usr/bin/fish
```

```
sudo shutdown -r now
```

### Nicer VIM colors

create `~/.vimrc` and add

    :color desert
    
### Ensure encrypted VNC connection

Edit `~/.vnc/config` and uncomment and edit the SecurityTypes line to be:

    securitytypes=tlsvnc

### fastStructure

```
cd /usr/local/src/
sudo git clone https://github.com/rajanil/fastStructure
cd /usr/local/src/fastStructure/
sudo git fetch
sudo git merge origin/master
sudo updatedb
sudo locate gsl_sf_psi.h
sudo locate libgslcblas.so
sudo locate libgsl.so
set -x LDFLAGS "-L/usr/lib/x86_64-linux-gnu"
set -x CFLAGS "-I/usr/include"
set -x LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu
cd vars
sudo python setup.py build_ext --inplace
cd ../
sudo python setup.py build_ext --inplace
cd /usr/local/bin
sudo nano fastStructure
```
add in following

```
#!/bin/bash
python /usr/local/src/fastStructure/structure.py
```
make executable

```
sudo chmod 755 fastStructure
```


### igv
go to [igv downloads](http://software.broadinstitute.org/software/igv/download) and download the binary version (currently 2.5.0)

```
cd Downloads/
unzip IGV_Linux_2.5.0.zip 
sudo mv IGV_Linux_2.5.0/ /usr/local/src
sudo ln -s /usr/local/src/IGV_Linux_2.5.0/igv.sh /usr/local/bin
```

### STAR

Download from https://github.com/alexdobin/STAR

```
cd /usr/local/src
sudo wget https://github.com/alexdobin/STAR/archive/2.7.0e.tar.gz
sudo tar -xzf 2.7.0e.tar.gz
cd /usr/local/bin
ln -s /usr/local/src/STAR-2.7.0e/bin/Linux_x86_64/STAR .
```

## screenshooter

Add panel for screenshooter via the GUI
