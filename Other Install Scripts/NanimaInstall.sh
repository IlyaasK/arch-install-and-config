#!usr/bin/env bash
pacman-mirrors --fasttrack #Fastest mirrors
pacman -Syyu #upgrade

#install apps, multimedia codecs and file systems
pacman -S --noconfirm net-tools pamac-cli okular qbittorent wine python wine-mono wine_gecko winetricks jdk8-openjdk youtube-dl jre8-openjdk jre8-openjdk-headless pavucontrol fail2ban ufw gufw pulseaudio vlc telegram gparted stacer kitty flatpak snapd aspell-en libmythes mythes-en languagetool htop neofetch redshift bitwarden git zsh vim linux-zen linux-zen-headers base-devel exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer0.10-plugins flashplugin libdvdcss libdvdread libdvdnav gecko-mediaplayer curl dvd+rw-tools dvdauthor dvgrab
pacman -R --noconfirm steam 

#AUR
pacman -Syu yaourt
yaourt -Syu
yaourt -S --noconfirm brave-bin ttf-ms-fonts zoom auto-cpufreq-git whatsapp-nativefier paru yay onlyoffice-bin

#change swappiness to 10
echo "vm.swappiness=10" > /etc/sysctl.d/100-manjaro.conf

#enable trim
systemctl enable fstrim.timer
systemctl start fstrim.timer

#enable auto cpu freq
systemctl enable auto-cpufreq
systemctl status auto-cpufreq

#enable snap CLI
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap

#enabke AUR (Snap and Flatpak to be done)
sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf" #enable AUR
sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf" #enable AUR updates

#Quick ZSH setup
git clone https://github.com/jotyGill/quickz-sh.git
cd quickz-sh
./quickz.sh -c 

# --- Setup UFW rules
ufw limit 22/tcp  
ufw allow 80/tcp  
ufw allow 443/tcp  
ufw default deny incoming  
ufw default allow outgoing
ufw enable

# --- Harden /etc/sysctl.conf
sysctl -a
sysctl -A
sysctl mib
sysctl net.ipv4.conf.all.rp_filter
sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS
cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

# --- Enable fail2ban
cp fail2ban.local /etc/fail2ban/
systemctl enable fail2ban
systemctl start fail2ban