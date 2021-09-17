#!usr/bin/env bash
pacman-mirrors --fasttrack #Fastest mirrors
pacman -R --noconfirm steam firefox gimp hexchat 
pacman -Syyu #upgrade

#install apps, multimedia codecs and file systems
sudo pacman -S --noconfirm p7zip net-tools notepadqq linux-headers linux-lts linux-lts-headers okular qbittorent wine python wine-mono wine_gecko winetricks jdk-openjdk youtube-dl jre-openjdk jre-openjdk-headless pavucontrol fail2ban ufw gufw pulseaudio vlc telegram gparted stacer kitty flatpak snapd aspell-en libmythes mythes-en languagetool htop neofetch redshift bitwarden git zsh vim linux-zen linux-zen-headers base-devel flashplugin 

#AUR
pacman -S yay
yay -Syu
yay -S --noconfirm paru onlyoffice-bin brave-bin ttf-ms-fonts zoom auto-cpufreq-git whatsapp-nativefier 

#change swappiness to 10
echo "vm.swappiness=10" > /etc/sysctl.d/100-manjaro.conf

#enable trim
systemctl enable --now fstrim.timer

#enable auto cpu freq
systemctl enable --now auto-cpufreq
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
ufw enable --now

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
systemctl enable --now fail2ban

#Blackarch repository
curl -O https://blackarch.org/strap.sh
echo edf8a85057ea49dce21eea429eb270535f3c5f9a strap.sh | sha1sum -c
chmod +x strap.sh
./strap.sh

# Enable tap touchpad to click
xfconf-query -c pointers -n -p /SynPS2_Synaptics_TouchPad/Properties/libinput_Tapping_Enabled -t int -s 1

# Auto mount drives and media
xfconf-query -c thunar-volman -n -p /automount-drives/enabled -t bool -s true;
xfconf-query -c thunar-volman -n -p /automount-media/enabled -t bool -s true;

printMessage "Enable multilib in pacman.conf, them pacman -Syu"