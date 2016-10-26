# AWS_Setup

```
sudo apt-get update
sudo apt-get upgrade
sudo vim /etc/ssh/sshd_config
##Change PasswordAuthentication to yes from no, then save and exit.
sudo /etc/init.d/ssh restart
sudo –i
passwd ubuntu
su ubuntu
cd
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get update
sudo -E apt-get install -y ubuntu-desktop
sudo apt-get install xfce4 xrdp
sudo apt-get install xfce4 xfce4-goodies
echo xfce4-session > ~/.xsession
sudo cp /home/ubuntu/.xsession /etc/skel
sudo vim /etc/xrdp/xrdp.ini
## under [xrdp1] change port=-1 to port=5911
sudo cim ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
## change <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
## to
## <property name="&lt;Super&gt;Tab" type="empty"/>
sudo service xrdp restart
## RDC in and go to applications/settings/appearance and alter icons to make them appear correctly
