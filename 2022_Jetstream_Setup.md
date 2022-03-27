From Image: Featured-Ubuntu20  
Flavor: m3.medium  

 * 8 CPU cores  
 * 30 GB RAM  
 * 60 GB Root Disk
  
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

### Installing R packages within Rstudio under /home/ubuntu/R/x86_64-pc-linux-gnu-library/4.1 [Default]
