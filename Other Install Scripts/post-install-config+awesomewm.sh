#!/bin/bash
reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syu

sudo systemctl enable --now auto-cpufreq
sudo systemctl enable --now tuned

#other config

#opendoas config
sudo echo "permit persist ilyaas as root" > /etc/doas.conf

#secure linux
cd secure-linux
chmod +x secure.sh
./secure.sh

sudo updatedb

#install photoshop
mkdir $HOME/gitclone
cd $HOME/gitclone
git clone https://github.com/Gictorbit/photoshopCClinux.git
cd photoshopCClinux
chmod +x setup.sh
./setup.sh

#figure out piracy of davinci resolve
#Dmenu vocab script bugswriter
