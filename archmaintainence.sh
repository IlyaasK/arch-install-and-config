#!/bin/sh

sudo reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu
pacrmorphans
sudo systemctl --failed
sudo journalctl -p 3 -xb

