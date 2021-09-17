#!usr/bin/env bash
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade

#change swappiness to 10
echo "vm.swappiness=10" > /etc/sysctl.d/100-manjaro.conf

#enable trim
systemctl enable --now fstrim.timer

#enable snap CLI
apt install snapd flatpak
systemctl enable --now snapd apparmor

# Enable tap touchpad to click
xfconf-query -c pointers -n -p /SynPS2_Synaptics_TouchPad/Properties/libinput_Tapping_Enabled -t int -s 1

# Auto mount drives and media
xfconf-query -c thunar-volman -n -p /automount-drives/enabled -t bool -s true;
xfconf-query -c thunar-volman -n -p /automount-media/enabled -t bool -s true;