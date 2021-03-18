# Notes and procedure on creating instance
**Need to work in N. Virginia**

# AWS_Setup_2021

## Base Instance Creation
Contents of Base Instance
  1. Ubuntu Server 20.04 LTS AMI 64-bit(x86)
  2. 2 Core, 4 Gb RAM
  3. 30Gb EBS storage
  4. Security

| Type     | Protocol | Port Range | Source  | Description |
|----------|----------|------------|---------|-------------|
|HTTP      |TCP       |80          |0.0.0.0/0|Webhosting   |
|HTTP      |TCP       |80          |::/0     |Webhosting   |
|SSH       |TCP       |22          |0.0.0.0/0|SSH          |
|Custom TCP|TCP       |5901        |0.0.0.0/0|VNC          |
|Custom TCP|TCP       |5901        |::/0     |VNC          |
    
  5. Elastic IP (Since been released)

```
sudo apt-get update
sudo apt-get upgrade
sudo nano /etc/ssh/sshd_config
##Change PasswordAuthentication to yes from no, then save and exit.
sudo /etc/init.d/ssh restart
sudo passwd ubuntu #"Genomics"
sudo apt install xfce4 xfce4-goodies libssl-dev #gbm3
cd /usr/local/src
sudo wget https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.11.0.x86_64.tar.gz
sudo tar -xzvf download_file\?file_path\=tigervnc-1.11.0.x86_64.tar.gz
sudo rm download_file\?file_path\=tigervnc-1.11.0.x86_64.tar.gz
cd /usr/bin
sudo cp -s ../local/src/tigervnc-1.11.0.x86_64/usr/bin/* .
sudo cp -s ../local/src/tigervnc-1.11.0.x86_64/usr/libexec/* .
vncpasswd #Genomics

```
