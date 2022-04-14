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
echo "INSTALLING UTILS"
echo

PKGS=(
        # AUDIO ---------------------------------------------------------------
        'alsa-utils' 
        'pipewire' 
        'pipewire-alsa' 
        'pipewire-pulse' 
        'pipewire-jack' 
        'sof-firmware'
        'gstreamer' 
        'gst-plugins-good'
        'gst-plugins-bad'
        'gst-plugins-base'
        'gst-plugins-ugly'
        'playerctl'
        # BLUETOOTH UTILS -----------------------------------------------------
        'bluez' 
        'bluez-utils' 
        # POWER ---------------------------------------------------------------
        'acpi' 
        'acpi_call' 
        'power-profiles-daemon' 
        'acpid' 
        # TERMINAL UTILS ------------------------------------------------------
        'neofetch' 
        'htop'
        'exa'
        'starship'
        'speedtest-cli'
        # VIRTUALISATION ------------------------------------------------------
        'virt-manager' 
        'qemu' 
        'qemu-arch-extra' 
        'edk2-ovmf' 
        'bridge-utils' 
        'dnsmasq' 
        'vde2'
        # GRAPHIC DRIVERS (Note that this is specific to my hardware)----------
        'xf86-video-intel' 
        'xf86-video-amdgpu' 
        
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG"
done

echo
echo "DONE!"
echo

echo
echo 'ACTIVATING DEAMONS'
echo 
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sshd
sudo systemctl enable --now avahi-daemon
sudo systemctl enable --now power-profiles-daemon
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now fstrim.timer
sudo systemctl enable --now libvirtd
sudo systemctl enable --now acpid
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'SETTING USER GROUPS (change to your "username")'
echo 
sudo usermod -aG libvirt,libvirt-qemu,kvm username
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'INSTALLING THE AUR HELPER'
echo 
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si --noconfirm
sleep 2
echo
echo 'DONE!'
echo -e '\033[1;32mCHOSE A DESKTOP ENVIRONMENT TO INSTALL AND RUN ./03.x.... .sh\033[m'
echo 
