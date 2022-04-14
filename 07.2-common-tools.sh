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
echo "INSTALLING SOFTWARES"
echo

PKGS=(
        'pamac-aur'
        'firefox'
        'obs-studio'
        'simplescreenrecorder'                
        'vlc'         
        'pavucontrol'
        'google-chrome'
        'brave-bin' 
        'megasync-git' 
        'stacer-bin' 
        'discord' 
        'betterdiscord-installer'
        'audacious'
        'audacious-plugins'
        'youtube-dl'
        'qbittorrent'
        'numlockx'

        
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG"
done

echo
echo -e '\033[1;32mUncomment multilib repos in /etc/pacman.com then RUN ./07.3.multilib-drivers.sh\033[m'
echo 
