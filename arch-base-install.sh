l#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime 
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S mtools inetutils btrfs-progs grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant dosfstools reflector base-devel linux-headers linux-zen linux-zen-headers avahi xdg-user-dirs xdg-utils inetutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack rsync reflector acpi acpi_call iptables-nft ipset acpid os-prober ntfs-3g

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m ilyaas
echo ilyaas:password | chpasswd
usermod -aG libvirt ilyaas

echo "ilyaas ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

