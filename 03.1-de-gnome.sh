#!/bin/bash
#-------------------------------------------------------------------------
#                                                                     
#  ██   ██ ███    ███ ██     ██        █████  ██████   ██████ ██   ██ 
#  ██   ██ ████  ████ ██     ██       ██   ██ ██   ██ ██      ██   ██ 
#  ███████ ██ ████ ██ ██  █  ██ █████ ███████ ██████  ██      ███████ 
#  ██   ██ ██  ██  ██ ██ ███ ██       ██   ██ ██   ██ ██      ██   ██ 
#  ██   ██ ██      ██  ███ ███        ██   ██ ██   ██  ██████ ██   ██ 
#                                                                     
#                   Arch Linux Installations scripts 
#-------------------------------------------------------------------------

echo
echo 'SYNCHRONIZING CLOCK'
echo 
sudo timedatectl set-ntp true
sudo hwclock --systohc
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'GETTING THE FASTEST MIRRORS'
echo 
sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist
sudo pacman -Syy
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'SETTING UP THE FIREWALL'
echo 
sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload
sleep 2
echo
echo 'DONE!'
echo 

echo
echo "INSTALLING GNOME DESKTOP ENVIRONMENT"
echo

PKGS=(
        'gdm'
        'gnome'              
        'gnome-extra'        
        'gnome-tweaks'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG"
done

echo
echo "DONE!"
echo

echo
echo "ENABLING THE DISPLAY MANAGER"
echo
sudo systemctl enable gdm
echo
echo 'DONE!'
echo -e '\033[1;32mRUN ./04-fonts.sh\033[m'
echo 