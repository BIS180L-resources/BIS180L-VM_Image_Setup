From Image: Ubuntu20
Flavor: m3.quad  

 * 4 CPU cores  
 * 15 GB RAM  
 * 80 GB Root Disk (Custom size, increase from 20 to 80 GB)

Add SSH Key  
Add Web Desktop
3 minutes to build

Open Web Desktop  
Click through initial setup  
Accept software update  

ctrl-alt-t

### Install packages and libraries
```
sudo -i
apt update

export NEEDRESTART_MODE=a # prevents interactice restart services screen from popping up

apt install libcurl4-openssl-dev -y #needed for bioconductor
apt install libboost-iostreams-dev -y
apt install libgsl0-dev -y
apt install libmysql++-dev -y
apt install libboost-graph-dev -y
apt install libgl1-mesa-dev -y #for rgl
apt install libglu1-mesa-dev -y #for rgl
apt install libmysqlclient-dev -y #for R mysql
apt install libfontconfig1-dev -y
apt install libmpfr-dev -y 
apt install libgmp-dev -y
apt install openmpi-bin -y
apt install libopenmpi-dev -y
apt install mysql-client -y
apt install mysql-server -y
apt install libssl-dev -y
apt install libudunits2-dev -y
apt install libxml2-dev -y
apt install cargo -y 
apt install libcairo2-dev -y
apt install libmagick++-dev -y
apt install libxslt1-dev -y
apt install libgeos-dev -y 
apt install libgdal-dev -y
apt install libpq-dev -y
apt install libfftw3-3 libfftw3-dev -y 
apt install libgconf-2-4 -y
apt install texlive-latex-extra -y
apt install texlive-fonts-recommended -y
apt install dkms -y
apt install liblist-moreutils-perl -y
apt install libstatistics-descriptive-perl -y 
apt install libstatistics-r-perl -y
apt install perl-doc -y
apt install libtext-table-perl -y
apt install gdebi-core -y
apt install cmake -y
apt install cython -y
apt install gedit gir1.2-gtksource-3.0 -y
apt install default-jdk -y 
apt install openjdk-8-jdk -y
apt install ruby-dev nodejs -y
apt install python3-pip python3-numpy python3-scipy -y
apt install libharfbuzz-dev libfribidi-dev -y
apt install bwa -y # probably not needed use hisat
apt install bowtie2 -y # probably not needed use hisat
apt install hisat2 python3-hisat2 -y 
apt install bedtools -y
apt install freebayes -y
# apt install busco -y # Broken.  Use bioconda, see below
apt install mafft -y
apt install probalign -y
apt install t-coffee -y
apt install fasttree -y


exit
```

# Make minimize and maximize buttons appear
```
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
```

# Fix date and time
```
sudo dpkg-reconfigure tzdata
```

# Change keybinding for nano whereis

add line below, OR just scroll to the end of the file and comment/uncomment bindings as desired
```
sudo nano /etc/nanorc
# Add
bind ^f whereis main
```

# Make the toolbar more windows like  
```
sudo apt-get install chrome-gnome-shell
```

Add native installer extension from https://extensions.gnome.org/  (on that website click on the link in the purple box near the top to add the installer.  This allows gnome extensions to be installed from the web browser)

Turn on and install "Dash to Panel" (search for it with search bar and then click the switch)

# Make BIS180L site homepage

### Installing latest R 

Although the base Ubuntu 22 image has R and RStudio they are out of date.

Go to [https://cran.r-project.org/](cran) to get latest script
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

Check Posit website for latest
```
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.1-402-amd64.deb
sudo gdebi rstudio-2023.12.1-402-amd64.deb  # y
rm rstudio-2023.12.1-402-amd64.deb 
## Edit the exec command of ~/.local/share/applications/rstudio.desktop to just run rstudio and not that module crap
```

### Installing R packages 

Install what we can from the apt system. It is faster because packages do not need to be compiled    
```

# add another repository

sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+

sudo apt update

sudo apt install --no-install-recommends r-cran-swirl r-cran-tidyverse r-cran-seqinr r-cran-qtl r-cran-evaluate  r-cran-highr r-cran-markdown r-cran-yaml r-cran-htmltools  r-cran-bitops r-cran-knitr r-cran-rmarkdown r-cran-devtools r-cran-shiny r-cran-pvclust r-cran-gplots r-cran-cluster r-cran-igraph r-cran-scatterplot3d r-cran-ape r-cran-rsconnect  r-cran-poisbinom r-cran-biocmanager  r-cran-igraph r-cran-ggdendro r-cran-upsetr r-cran-statgengwas
```

```
sudo -i

R 

# within R: #installs into /usr/local/lib/R/site-library since we are sudo
# Cran packages
install.packages(c('hwde', 'caTools', 'formatR'), dependencies=T)

# Install Biocondutor packages    
BiocManager::install(c("BiocStyle","snpStats","rtracklayer","goseq","impute","multtest","VariantAnnotation","chopsticks","edgeR", "GenomicRanges"))

# Github packages
devtools::install_github(repo = "cran/PSMix")

# below not needed?
# devtools::install_github(repo = "jiabowang/GAPIT3", force=TRUE)
# install.packages('SNPassoc')
# install.packages("EMMREML")
# devtools::install_github("YaoZhou89/BLINK")
# install.packages("https://cran.r-project.org/src/contrib/Archive/LDheatmap/LDheatmap_1.0-6.tar.gz", repo = NULL, type = "source")

# BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene", lib = "/home/exouser/R/x86_64-pc-linux-gnu-library/4.2")
# BiocManager::install("org.Hs.eg.db", lib = "/home/exouser/R/x86_64-pc-linux-gnu-library/4.2")
```

### Install BFG

```
sudo wget -O /usr/local/src/bfg.jar https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
sudo bash -c 'echo "java -jar /usr/local/src/bfg.jar \$*" > /usr/local/bin/bfg'
sudo chmod +x /usr/local/bin/bfg
```

### Install github desktop

See https://github.com/shiftkey/desktop

```
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
sudo apt update && sudo apt install github-desktop
```

### Installing BLAST 2.15.0+ from NCBI (version 2.12 installed by default, replace it with code below)

```
cd /usr/local/src
sudo wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.15.0+-x64-linux.tar.gz
sudo tar zxvpf ncbi-blast-2.15.0+-x64-linux.tar.gz
sudo rm ncbi-blast-2.15.0+-x64-linux.tar.gz
cd /usr/local/bin
sudo ln -sf /usr/local/src/ncbi-blast-2.15.0+/bin/* .
cd
```

### Installing Tophat
__Probably not needed, use HISAT2 instead__
```
cd /usr/local/src
sudo wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.1.Linux_x86_64.tar.gz
sudo tar xvfz tophat-2.1.1.Linux_x86_64.tar.gz
sudo rm tophat-2.1.1.Linux_x86_64.tar.gz
cd /usr/local/bin
sudo ln -s /usr/local/src/tophat-2.1.1.Linux_x86_64/tophat .
```

### Installing Samtools, bctools, htslib
(apt versions are way behind)
```
cd /usr/local/src
sudo wget https://github.com/samtools/samtools/releases/download/1.19.2/samtools-1.19.2.tar.bz2
sudo tar xvfj samtools-1.19.2.tar.bz2
sudo rm samtools-1.19.2.tar.bz2
cd samtools-1.19.2
sudo ./configure --prefix=/usr/local/bin
sudo make
sudo make install

cd /usr/local/src
sudo wget https://github.com/samtools/bcftools/releases/download/1.19/bcftools-1.19.tar.bz2
sudo tar xvfj bcftools-1.19.tar.bz2
sudo rm bcftools-1.19.tar.bz2
cd bcftools-1.19
sudo ./configure --prefix=/usr/local/bin
sudo make
sudo make install

cd /usr/local/src
sudo wget https://github.com/samtools/htslib/releases/download/1.19.1/htslib-1.19.1.tar.bz2
sudo tar xvfj htslib-1.19.1.tar.bz2
sudo rm htslib-1.19.1.tar.bz2
cd htslib-1.19.1
sudo ./configure --prefix=/usr/local/bin
sudo make
sudo make install
```

### Installing Fastqc

```
cd /usr/local/src
sudo wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip
sudo unzip fastqc_v0.12.1.zip
sudo rm fastqc_v0.12.1.zip
cd FastQC/
sudo chmod 0755 fastqc
cd /usr/local/bin
sudo cp -s ../src/FastQC/fastqc .
cd
```

### Installing seqtk
__NOT NEEDED__
```
# cd /usr/local/src
# sudo git clone https://github.com/lh3/seqtk.git
# cd seqtk
# sudo make
# cd /usr/local/bin
# sudo ln -s /usr/local/src/seqtk/seqtk .
# cd
```

### Installing Cufflinks
__NOT NEEDED__
```
# cd /usr/local/src
# sudo wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
# sudo tar -xvzf cufflinks-2.2.1.Linux_x86_64.tar.gz
# sudo rm cufflinks-2.2.1.Linux_x86_64.tar.gz
# cd /usr/local/bin
# sudo ln -s /usr/local/src/cufflinks-2.2.1.Linux_x86_64/cuff* .
# sudo ln -s /usr/local/src/cufflinks-2.2.1.Linux_x86_64/g* .
# cd
```

### Installing GATK 4.5.0.0

```
cd /usr/local/src
sudo wget https://github.com/broadinstitute/gatk/releases/download/4.5.0.0/gatk-4.5.0.0.zip
sudo unzip gatk-4.5.0.0.zip
sudo rm gatk-4.5.0.0.zip
cd /usr/local/bin
sudo ln -s /usr/local/src/gatk-4.5.0.0/gatk .
cd
```

### fastStructure
__ Can't install due to python2 dependency.  Alternatives are ADMIXTURE or SambaR; see below__


### ADMIXTURE
https://dalexander.github.io/admixture/download.html
```
cd /usr/local/src
sudo wget https://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz
sudo tar -xvzf admixture_linux-1.3.0.tar.gz
cd ../bin
sudo ln -s /usr/local/src/dist/admixture_linux-1.3.0/admixture .
cd
```

### SambaR
https://github.com/mennodejong1986/SambaR

Not really an R package, but wrappers that can help with the admixture analysis in R

```
cd /usr/local/src
sudo git clone https://github.com/mennodejong1986/SambaR.git
cd SambaR
sudo R

# in R
source("SAMBAR_v1.10.txt")
getpackages()
```

### htseq

```
pip install HTseq
```



### [hifiasm](https://github.com/chhylp123/hifiasm)
```
sudo -i

cd /usr/local/src
git clone https://github.com/chhylp123/hifiasm
cd hifiasm
make
cd /usr/local/bin
ln -s /usr/local/src/hifiasm/hifiasm ./
exit
```

### Miniconda (needed for pbmmap2)

See https://docs.anaconda.com/free/miniconda/miniconda-install/

Do as exouser, not root
```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash
source .bashrc

```

Got warning: do I need to deal with this?
WARNING:
    You currently have a PYTHONPATH environment variable set. This may cause
    unexpected behavior when running the Python interpreter in Miniconda3.
    For best results, please verify that your PYTHONPATH only points to
    directories of packages that are compatible with the Python interpreter
    in Miniconda3: /home/exouser/miniconda3


### [PacBio MiniMap2](https://github.com/PacificBiosciences/pbmm2)
[Install Instructions](https://github.com/PacificBiosciences/pbbioconda)

Also [seqkit](https://github.com/shenwei356/seqkit) and [busco]()
```
conda create --name pb-minimap2
conda activate pb-minimap2
conda install -c bioconda pbmm2
conda install -c bioconda seqkit
conda install -c conda-forge -c bioconda busco
conda deactivate
```

### [PacBio CpG Tools](https://github.com/PacificBiosciences/pb-CpG-tools)

```
sudo -i

cd /usr/local/src

wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.2/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz

tar -xzf pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz

cd /usr/local/bin/
ln -s /usr/local/src/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores ./
exit
```

### [bbmap](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/installation-guide/)
installing to get `stats.sh` for sequence assembly stats

```
sudo apt install bbmap
sudo ln -s /usr/share/bbmap/stats.sh /usr/local/bin/
```

### [fastp](https://github.com/OpenGene/fastp?tab=readme-ov-file)
Alternative to trimmomatic
```
sudo -i

cd /usr/local/bin
wget http://opengene.org/fastp/fastp
chmod a+x ./fastp
```

### igv
go to [igv downloads](http://software.broadinstitute.org/software/igv/download) and download the binary version (currently 2.16)

```
cd /usr/local/src
sudo wget https://data.broadinstitute.org/igv/projects/downloads/2.17/IGV_Linux_2.17.4_WithJava.zip
sudo unzip IGV_Linux_2.17.4_WithJava.zip
sudo rm IGV_Linux_2.17.4_WithJava.zip
sudo ln -s /usr/local/src/IGV_Linux_2.17.4/igv.sh /usr/local/bin/igv
cd
```

### STAR

Download from https://github.com/alexdobin/STAR

```
cd /usr/local/src
sudo wget https://github.com/alexdobin/STAR/archive/refs/tags/2.7.11b.tar.gz
sudo tar -xzf 2.7.11b.tar.gz
cd /usr/local/bin
sudo ln -s /usr/local/src/STAR-2.7.11b/bin/Linux_x86_64_static/STAR .
cd 
```

## Installing [fail2ban](https://github.com/fail2ban/fail2ban)
This software blocks ssh access after X failed attempts (default 10)
```
sudo apt install fail2ban
```

## update Rstudio prefs

Do not restore workspace with .Rdata
Never save workspace to .Rdata
Softwrap R source files

## Install slack
```
# download .deb from slack website using firefox on the instance
# in terminal
cd Downloads
sudo gdebi slack-desktop-4.29.149-amd64.deb #y
```

### Add class data to image

```
cd ~
wget http://malooflab.phytonetworks.org/media/maloof-lab/filer_public/8f/d5/8fd59de6-e311-4d50-8320-acc58402982f/bis180l_class_data_2020tar.gz
tar -xzvf bis180l_class_data_2020tar.gz
rm bis180l_class_data_2020tar.gz
```

## Change VNC server Settings
```
sudo vi /etc/systemd/system/vncserver@.service

## edit the `ExecStart` line to match what is below.  This allows vnc to listen on all incoming IPs, and requires TLS encryption.  LEave the rest of the file as is

ExecStart=/usr/bin/vncserver -fg -SecurityTypes TLSVnc -localhost no -rfbauth /home/exouser/.vnc/p

```

### Refresh server and change password
# Do by ssh, not web desktop
```
vncpasswd # Genomics
sudo systemctl daemon-reload
vncserver -kill :1
sudo systemctl enable vncserver@1.service
sudo systemctl restart vncserver@1
sudo systemctl status vncserver@1 # to check
```

## SSH public key

You may want to add a ssh public key to `~/.ssh/authorized_keys` so that if things go south with a student's VM you can try logging on that way

# Create image snapshot
On Jetstream gui click create snapshot image of instance under actions while server is running

# Create new instances
Image: BIS180_Base-image
Flavor: m3.quad  

 * 4 CPU cores  
 * 15 GB RAM  
 * 80 GB Root Disk (Custom size, increase from 20 to 80 GB)

**DO NOT Add Web Desktop** (Doing so will wipe out vnc settings)

# Ready for class
