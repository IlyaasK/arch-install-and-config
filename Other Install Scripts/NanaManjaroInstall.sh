#!/bin/bash
sudo pacman-mirrors --fasttrack #Fastest mirrors
sudo pacman -R --noconfirm steam firefox gimp hexchat 
sudo pacman -Syu #upgrade

#enable colour in pacman and therefore, paru
grep -q "^Color" /etc/pacman.conf || sed -i "s/^#Color$/Color/" /etc/pacman.conf

#install apps, multimedia codecs and file systems
sudo pacman -S p7zip net-tools notepadqq linux-headers linux-lts linux-lts-headers okular qbittorent python youtube-dl fail2ban ufw vlc gparted stacer kitty neofetch redshift bitwarden git zsh neovim base-devel exfat-utils ffmpeg ntfs-3g hplip system-config-printer cups fwupd git zsh moreutils unclutter rkhunter auto-cpufreq onlyoffice-desktopeditors

sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf # Use all cores for compilation.

#AUR
sudo pacman -S yay
yay -Syu
yay -S czkawka-gui-bin brave-bin zsh-fast-syntax-highlighting simple-mtpfs xkill-shortcut

#change swappiness to 10
sudo echo "vm.swappiness=10" > /etc/sysctl.d/100-manjaro.conf

#enable trim
sudo systemctl enable --now fstrim.timer

#enable auto cpu freq
sudo systemctl enable --now auto-cpufreq                                                                                                                     
#enable AUR                                                                            
sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf" #enable AUR                        
sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf" #enable AUR updates                      

# --- Setup UFW rules                                                                          
sudo ufw limit 22/tcp                                                                          
sudo ufw allow 80/tcp                                                                          
sudo ufw allow 443/tcp                                                                         
sudo ufw default deny incoming  
sudo ufw default allow outgoing
sudo ufw enable

# --- Harden /etc/sysctl.conf                                                      
sudo sysctl -a
sudo sysctl -A
sudo sysctl mib               
sudo sysctl net.ipv4.conf.all.rp_filter
sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS                                                                       
cat <<EOF > /etc/host.conf                       
order bind,hosts
multi on                                                                                      
EOF

# --- Enable fail2ban
sudo cp fail2ban.local /etc/fail2ban/
sudo systemctl enable --now fail2ban

# Enable tap touchpad to click
xfconf-query -c pointers -n -p /SynPS2_Synaptics_TouchPad/Properties/libinput_Tapping_Enabled -t int -s 1

# Auto mount drives and media
xfconf-query -c thunar-volman -n -p /automount-drives/enabled -t bool -s true;
xfconf-query -c thunar-volman -n -p /automount-media/enabled -t bool -s true;

#ZSH config
sudo pacman -S zsh-autosuggestions zsh-completions zsh-history-substring-search zshdb

# Make zsh the default shell for the user.
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"

echo "configured, rebooting now"
sudo reboot
