sudo pacman --noconfirm -S zsh python-pywal git picom ttf-hack ttf-joypixels noto-fonts noto-fonts-cjk noto-fonts-emoji xdotool
sudo pacman --noconfirm -R dmenu

# BuildingSuckless
cd .local/src
git clone https://github.com/LukeSmithxyz/dwm.git
cd dwm
sudo make clean install
cd ..
git clone https://github.com/LukeSmithxyz/st.git
cd st
sudo make clean install
cd ..
git clone https://github.com/LukeSmithxyz/dwmblocks.git
cd dwmblocks
sudo make clean install
cd ..
git clone https://github.com/LukeSmithxyz/dmenu.git
cd dmenu
sudo make clean install
cd

# xinitrc stuff bitch
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i -r '/^\s*$/d' ~/.xinitrc
echo "dwmblocks &" >> ~/.xinitrc
echo "picom &" >> ~/.xinitrc
echo "setbg ~/.config/wall.png" >> ~/.xinitrc
echo "while true; do" >> ~/.xinitrc
echo "  exec dwm >/dev/null 2>&1" >> ~/.xinitrc
echo "done" >> ~/.xinitrc
echo "exec dwm" >> ~/.xinitrc
