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
echo "INSTALLING THEMING CONFIGS"
echo

PKGS=(
        'kvantum'
        'papirus-icon-theme'                 
        'capitaine-cursors'   
        'gtk-engines'  
        'gtk-engine-murrine'  
        'arc-gtk-theme' 
        'arc-icon-theme'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG"
done

echo
echo 'DONE!'
echo -e '\033[1;32mOptionally Configure & RUN ./06.1.root-post-install.sh as root\033[m'
echo 