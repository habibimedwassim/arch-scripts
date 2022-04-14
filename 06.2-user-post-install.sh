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
        # GENERAL UTILITIES ---------------------------------------------------
        'libgnome-keyring'
        'gnome-keyring'
        'unrar'                
        'unzip'         
        'zip'
        'variety'        
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG"
done

echo
echo 'DONE!'
echo -e '\033[1;32mRUN ./07.1.dev-tools.sh\033[m'
echo 
