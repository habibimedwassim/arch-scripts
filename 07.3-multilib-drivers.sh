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
sudo pacman -Syy
PKGS=(
        'vulkan-radeon'
        'amdgpu-pro-libgl' 
        'lib32-amdgpu-pro-libgl' 
        'lib32-mesa' 
        'lib32-vulkan-driver' 
        'opengl-man-pages' 
        'lib32-mesa-vdpau' 
        'lib32-libva-mesa-driver' 
        'vulkan-icd-loader' 
        'lib32-vulkan-icd-loader'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG"
done

echo
echo 'DONE!'
echo -e '\033[1;32mCopy the content of 08-.bashrc to your ~/.bashrc & REBOOT...\033[m'
echo 
