From Image: Featured-Ubuntu20  
Flavor: m3.medium  

 * 4 CPU cores  
 * 15 GB RAM  
 * 30 GB Root Disk
  
Add SSH Key  
Add Web Desktop
3 minutes to build

Open Web Desktop  
Click through initial setup  
Accept software update  

ctrl-alt-t

# Hide mounts on desktop
```
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
```

# Make minimize and maximize buttons appear
```
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
```

# Change home terminal location
```
nano ~/.bashrc
# Add if [ "$PWD" != "$HOME" ]; then cd ~; fi
```

# Fix date and time
```
sudo dpkg-reconfigure tzdata
```

# Change keybinding for nano whereis
```
sudo nano /etc/nanorc
# Add
bind ^f whereis main
```

# Make the toolbar more windows like  
```
sudo apt-get install chrome-gnome-shell
```

Add native installer extension from https://extensions.gnome.org/  
Turn on and install dash-to-panel

### Installing Necessary Libraries and Programs

```
sudo -i
apt install curl -y
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
apt install ncbi-blast+ -y # this install 2.9 which a bit old
apt install ncbi-blast+-legacy -y 
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
apt install emboss -y
apt install default-jdk -y 
apt install openjdk-8-jdk -y
apt install ruby-dev nodejs -y
apt install python3-pip python3-numpy python3-scipy -y
exit
```

### Installing latest R
```
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install --no-install-recommends software-properties-common dirmngr
# import the signing key (by Michael Rutter) for these repo
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# add the R 4.1.3 repo from CRAN
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -sc)-cran40/"
# install R
sudo apt install --no-install-recommends r-base r-base-dev
```

### Installing Rstudio and make launcher
```
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.02.1-461-amd64.deb
sudo gdebi rstudio-2022.02.1-461-amd64.deb # y
rm rstudio-2022.02.1-461-amd64.deb
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

### Installing git viewer

```
sudo apt install gitg -y
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
```

### Installing Others

```
sudo apt install seaview -y
sudo apt install  mafft -y
```

### Installing BLAST 2.11.0+ from NCBI

```
cd /usr/local/src
sudo wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.13.0+-x64-linux.tar.gz
sudo tar zxvpf ncbi-blast-2.13.0+-x64-linux.tar.gz
sudo rm ncbi-blast-2.13.0+-x64-linux.tar.gz
cd /usr/bin
sudo ln -sf /usr/local/src/ncbi-blast-2.13.0+/bin/* .
```

### Installing BWA

```
cd /usr/local/src
sudo git clone https://github.com/lh3/bwa.git
cd bwa; sudo make
cd /usr/local/bin
sudo ln -s /usr/local/src/bwa/bwa .
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
sudo wget https://github.com/samtools/samtools/releases/download/1.15/samtools-1.15.tar.bz2
sudo tar xvfj samtools-1.15.tar.bz2
sudo rm samtools-1.15.tar.bz2
cd samtools-1.15
sudo ./configure --prefix=/usr/local/src/samtools-1.15
sudo make
sudo make install
cd /usr/local/bin
sudo ln -s /usr/local/src/samtools-1.15/bin/samtools .
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
```

### Installing seqtk

```
cd /usr/local/src
sudo git clone https://github.com/lh3/seqtk.git
cd seqtk
sudo make
cd /usr/local/bin
sudo ln -s /usr/local/src/seqtk/seqtk .
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
```

### Installing FreeBayes

```
cd /usr/local/src
sudo wget https://github.com/freebayes/freebayes/releases/download/v1.3.6/freebayes-1.3.6-linux-amd64-static.gz
sudo gunzip freebayes-1.3.6-linux-amd64-static.gz
sudo chmod +x freebayes-1.3.6-linux-amd64-static
cd /usr/local/bin
sudo ln -s /usr/local/src/freebayes-1.3.6-linux-amd64-static freebayes
```

### Installing GATK 4.1.0.0

```
cd /usr/local/src
sudo wget https://github.com/broadinstitute/gatk/releases/download/4.2.5.0/gatk-4.2.5.0.zip
sudo unzip gatk-4.2.5.0.zip
sudo rm gatk-4.2.5.0.zip
cd /usr/local/bin
sudo ln -s /usr/local/src/gatk-4.2.5.0/gatk .
```

### Installing Atom

```
sudo wget https://atom.io/download/deb
sudo mv deb atom.deb
sudo gdebi atom.deb
sudo rm atom.deb
```

Add atom packages:

* git-plus
* markdown-pdf
* line-ending-converter
* language-markdown
* Sublime-Style-Column-Selection

In atom, go to preferences and disable the 'whitespace' package

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
### igv
go to [igv downloads](http://software.broadinstitute.org/software/igv/download) and download the binary version (currently 2.9.4)

```
cd /usr/local/src
sudo wget https://data.broadinstitute.org/igv/projects/downloads/2.12/IGV_Linux_2.12.3_WithJava.zip
sudo unzip IGV_Linux_2.12.3_WithJava.zip
sudo rm IGV_Linux_2.12.3_WithJava.zip
sudo ln -s /usr/local/src/IGV_Linux_2.12.3/igv.sh /usr/local/bin/igv
```

### STAR

Download from https://github.com/alexdobin/STAR

```
cd /usr/local/src
sudo wget https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz
sudo tar -xzf 2.7.10a.tar.gz
cd /usr/local/bin
sudo ln -s /usr/local/src/STAR-2.7.10a/bin/Linux_x86_64_static/STAR .
```

### Add class data to image

```
cd
wget http://malooflab.phytonetworks.org/media/maloof-lab/filer_public/8f/d5/8fd59de6-e311-4d50-8320-acc58402982f/bis180l_class_data_2020tar.gz
tar -xzvf bis180l_class_data_2020tar.gz
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

