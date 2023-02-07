From Image: Ubuntu20
Flavor: m3.quad  

 * 4 CPU cores  
 * 15 GB RAM  
 * 60 GB Root Disk (Custom size, increase from 20 to 60 GB)

Add SSH Key  
Add Web Desktop
3 minutes to build

Open Web Desktop  
Click through initial setup  
Accept software update  

ctrl-alt-t

# Change VNC server Settings
```
sudo nano /etc/systemd/system/vncserver@.service
[Unit]
Description=TigerVNC Server
BindsTo=sys-devices-virtual-net-docker0.device
After=syslog.target network.target sys-devices-virtual-net-docker0.device
StartLimitIntervalSec=300
StartLimitBurst=5

[Service]
Type=simple
User=exouser
PAMName=login
PIDFile=/home/exouser/.vnc/%H%i.pid
ExecStartPre=/bin/sh -c 'ip address show dev docker0 | grep -q 172.17.0.1'
ExecStartPre=/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -fg -SecurityTypes X509Vnc -X509Key /home/exouser/.vnc/vnc-server-private.pem -X509Cert /home/exouser/.vnc/vnc-server.pem -localhost no -rfbauth /home/exouser/.vnc/passwd -MaxCutText 99999999 :%i
ExecStop=/usr/bin/vncserver -kill :%i
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

# Make key
```
cd ~/.vnc
nano make_secure.sh
# Add following
myIP=$(curl ifconfig.me)
openssl req \
  -x509 \
  -newkey rsa \
  -days 365 \
  -nodes \
  -config /usr/lib/ssl/openssl.cnf \
  -keyout vnc-server-private.pem \
  -out vnc-server.pem \
  -subj "/CN=${myIP}" \
  -addext "subjectAltName=IP:${myIP}"
```


# Change config
```
chmod u+x make_secure.sh
./make_secure.sh
```

# Copy vnc-server.pem to local machine

# Refresh server and change password
# Do by ssh in
```
vncpasswd # Genomics
sudo systemctl daemon-reload
vncserver -kill :1
sudo systemctl enable vncserver@1.service
sudo systemctl restart vncserver@1
sudo systemctl status vncserver@1 # to check
```

sudo apt-get install libharfbuzz-dev libfribidi-dev

### Installing latest R 4.2.2
```
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base # Y
```

### Installing Rstudio
```
sudo apt-get install gdebi-core
wget https://download1.rstudio.org/electron/bionic/amd64/rstudio-2022.12.0-353-amd64.deb
sudo gdebi rstudio-2022.12.0-353-amd64.deb # y
rm rstudio-2022.12.0-353-amd64.deb
## Edit the exec command of ~/.local/share/applications to just run rstudio and not that module crap
```

### Installing R packages within Rstudio under /home/exouser/R/x86_64-pc-linux-gnu-library/4.1 [Default]

```
# Cran packages
install.packages(c('swirl','ggplot2','genetics','hwde','seqinr','qtl','evaluate','formatR','highr','markdown','yaml','htmltools','caTools','bitops','knitr','rmarkdown','devtools','shiny','pvclust','gplots','cluster','igraph','scatterplot3d','ape','rsconnect','dplyr','tidyverse','learnr','poisbinom'), dependencies=T)
# Install Biocondutor packages    
install.packages("BiocManager")
BiocManager::install(c("Rsubread","BiocStyle","snpStats","rtracklayer","goseq","impute","multtest","VariantAnnotation","chopsticks","edgeR"))
# Github packages
devtools::install_github(repo = "cran/PSMix")
devtools::install_github(repo = "jiabowang/GAPIT3", force=TRUE)
# Others that depend on above packages
install.packages('LDheatmap')
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene", lib = "/home/exouser/R/x86_64-pc-linux-gnu-library/4.1")
BiocManager::install("org.Hs.eg.db", lib = "/home/exouser/R/x86_64-pc-linux-gnu-library/4.1")
install.packages('SNPassoc')
install.packages("EMMREML")
devtools::install_github("YaoZhou89/BLINK")
```

### Install BFG

```
sudo wget -O /usr/local/src/bfg.jar https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
sudo bash -c 'echo "java -jar /usr/local/src/bfg.jar \$*" > /usr/local/bin/bfg'
sudo chmod +x /usr/local/bin/bfg
```

### Install git-it desktop

```
cd /home/exouser/Desktop
wget https://github.com/jlord/git-it-electron/releases/download/4.4.0/Git-it-Linux-x64.zip
unzip Git-it-Linux-x64.zip
rm Git-it-Linux-x64.zip
cd
# create desktop link to executable
create file ~/.local/share/applications/Git-it.desktop
```

### Installing Others

```
sudo apt install seaview -y
sudo apt install  mafft -y
```

### Installing BLAST 2.13.0+ from NCBI

```
cd /usr/local/src
sudo wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.13.0+-x64-linux.tar.gz
sudo tar zxvpf ncbi-blast-2.13.0+-x64-linux.tar.gz
sudo rm ncbi-blast-2.13.0+-x64-linux.tar.gz
cd /usr/bin
sudo ln -sf /usr/local/src/ncbi-blast-2.13.0+/bin/* .
cd
```

### Installing BWA

```
cd /usr/local/src
sudo git clone https://github.com/lh3/bwa.git
cd bwa; sudo make
cd /usr/local/bin
sudo ln -s /usr/local/src/bwa/bwa .
cd
```

### Installing Bowtie

```
cd /usr/local/src
sudo wget https://sourceforge.net/projects/bowtie-bio/files/bowtie/1.3.1/bowtie-1.3.1-linux-x86_64.zip/download
sudo unzip download
sudo rm download
cd /usr/local/bin
sudo ln -s /usr/local/src/bowtie-1.3.1-linux-x86_64/bowtie .
sudo ln -s /usr/local/src/bowtie-1.3.1-linux-x86_64/bowtie-build .
sudo ln -s /usr/local/src/bowtie-1.3.1-linux-x86_64/bowtie-inspect .
cd
```

### Installing Bowtie2

```
cd /usr/local/src
sudo wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.5/bowtie2-2.4.5-linux-x86_64.zip
sudo unzip bowtie2-2.4.5-linux-x86_64.zip
sudo rm bowtie2-2.4.5-linux-x86_64.zip
cd /usr/local/bin
sudo ln -s /usr/local/src/bowtie2-2.4.5-linux-x86_64/bowtie2 .
sudo ln -s /usr/local/src/bowtie2-2.4.5-linux-x86_64/bowtie2-build .
sudo ln -s /usr/local/src/bowtie2-2.4.5-linux-x86_64/bowtie2-inspect .
cd
```

### Installing Tophat

```
cd /usr/local/src
sudo wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz
sudo tar xvfz tophat-2.1.1.Linux_x86_64.tar.gz
sudo rm tophat-2.1.1.Linux_x86_64.tar.gz
cd /usr/local/bin
sudo ln -s /usr/local/src/tophat-2.1.1.Linux_x86_64/tophat .
```

### Installing Samtools

```
cd /usr/local/src
sudo wget https://github.com/samtools/samtools/releases/download/1.16.1/samtools-1.16.1.tar.bz2
sudo tar xvfj samtools-1.16.1.tar.bz2
sudo rm samtools-1.16.1.tar.bz2
cd samtools-1.16.1
sudo ./configure --prefix=/usr/local/src/samtools-1.16.1
sudo make
sudo make install
cd /usr/local/bin
sudo ln -s /usr/local/src/samtools-1.16.1/bin/samtools .
cd
```

### Installing Bedtools2

```
cd /usr/local/src
sudo wget https://github.com/arq5x/bedtools2/releases/download/v2.30.0/bedtools-2.30.0.tar.gz
sudo tar -zxvf bedtools-2.30.0.tar.gz
sudo rm bedtools-2.30.0.tar.gz
cd bedtools2
sudo make
cd /usr/local/bin
sudo ln -s /usr/local/src/bedtools2/bin/* .
cd
```

### Installing Fastqc

```
cd /usr/local/src
sudo wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
sudo unzip fastqc_v0.11.9.zip
sudo rm fastqc_v0.11.9.zip
cd FastQC/
sudo chmod 0755 fastqc
cd /usr/local/bin
sudo cp -s ../src/FastQC/fastqc .
cd
```

### Installing seqtk

```
cd /usr/local/src
sudo git clone https://github.com/lh3/seqtk.git
cd seqtk
sudo make
cd /usr/local/bin
sudo ln -s /usr/local/src/seqtk/seqtk .
cd
```

### Installing Cufflinks

```
cd /usr/local/src
sudo wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
sudo tar -xvzf cufflinks-2.2.1.Linux_x86_64.tar.gz
sudo rm cufflinks-2.2.1.Linux_x86_64.tar.gz
cd /usr/local/bin
sudo ln -s /usr/local/src/cufflinks-2.2.1.Linux_x86_64/cuff* .
sudo ln -s /usr/local/src/cufflinks-2.2.1.Linux_x86_64/g* .
cd
```

### Installing FreeBayes

```
cd /usr/local/src
sudo wget https://github.com/freebayes/freebayes/releases/download/v1.3.6/freebayes-1.3.6-linux-amd64-static.gz
sudo gunzip freebayes-1.3.6-linux-amd64-static.gz
sudo chmod +x freebayes-1.3.6-linux-amd64-static
cd /usr/local/bin
sudo ln -s /usr/local/src/freebayes-1.3.6-linux-amd64-static freebayes
cd
```


### Installing GATK 4.1.0.0

```
cd /usr/local/src
sudo wget https://github.com/broadinstitute/gatk/releases/download/4.2.5.0/gatk-4.2.5.0.zip
sudo unzip gatk-4.2.5.0.zip
sudo rm gatk-4.2.5.0.zip
cd /usr/local/bin
sudo ln -s /usr/local/src/gatk-4.2.5.0/gatk .
cd
```

### fastStructure

```
cd /usr/local/src/
sudo curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo pip2 install --no-deps --ignore-installed --force-reinstall cython==0.27.3 numpy==1.16.5 scipy==1.2.1
sudo wget http://gnu.mirror.vexxhost.com/gsl/gsl-latest.tar.gz
sudo tar -zxvf gsl-latest.tar.gz
cd gsl-2.4
sudo ./configure
sudo make
sudo make install
cd ..
sudo rm -R gsl-latest.tar.gz gsl-2.4
sudo git clone https://github.com/rajanil/fastStructure.git
cd /usr/local/src/fastStructure/
sudo git fetch
sudo git merge origin/master
sudo apt update
sudo apt install locate
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
python /usr/local/src/fastStructure/structure.py $*
```

make executable

```
sudo chmod 755 fastStructure
```

#### NEED TO ADD THIS TO MAKE RUN EVERYTIME. SHOULD TWEAK ABOVE MENTIONS TO THIS
```
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu' >> ~/.bashrc
echo 'export LDFLAGS="-L/usr/lib/x86_64-linux-gnu"' >> ~/.bashrc
echo 'export CFLAGS="-I/usr/include"' >> ~/.bashrc
source ~/.bashrc
fastStructure
```


### igv
go to [igv downloads](http://software.broadinstitute.org/software/igv/download) and download the binary version (currently 2.16)

```
cd /usr/local/src
sudo wget https://data.broadinstitute.org/igv/projects/downloads/2.16/IGV_Linux_2.16.0_WithJava.zip
sudo unzip IGV_Linux_2.16.0_WithJava.zip
sudo rm IGV_Linux_2.16.0_WithJava.zip
sudo ln -s /usr/local/src/IGV_Linux_2.16.0/igv.sh /usr/local/bin/igv
cd
```

### STAR

Download from https://github.com/alexdobin/STAR

```
cd /usr/local/src
sudo wget https://github.com/alexdobin/STAR/archive/refs/tags/2.7.10b.tar.gz
sudo tar -xzf 2.7.10b.tar.gz
cd /usr/local/bin
sudo ln -s /usr/local/src/STAR-2.7.10b/bin/Linux_x86_64_static/STAR .
cd 
```

### Add class data to image

```
cd
wget http://malooflab.phytonetworks.org/media/maloof-lab/filer_public/8f/d5/8fd59de6-e311-4d50-8320-acc58402982f/bis180l_class_data_2020tar.gz
tar -xzvf bis180l_class_data_2020tar.gz
rm bis180l_class_data_2020tar.gz
```

## Installing MAFFT
```
wget https://mafft.cbrc.jp/alignment/software/mafft_7.490-1_amd64.deb
sudo dpkg -i mafft_7.490-1_amd64.deb
rm mafft_7.490-1_amd64.deb
```

## Installing FastTree
```
cd /usr/local/bin
sudo wget http://microbesonline.org/fasttree/FastTree
sudo chmod +x FastTree
```

## Installing [fail2ban](https://github.com/fail2ban/fail2ban)
This software blocks ssh access after X failed attempts (default 10)
```
sudo apt-get install fail2ban
```
