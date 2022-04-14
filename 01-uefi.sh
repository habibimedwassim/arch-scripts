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
echo 'SETTING UP THE TIMEZONE'
echo 
ln -sf /usr/share/zoneinfo/Africa/Tunis /etc/localtime
hwclock --systohc
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'SETTING UP THE LOCALE (US ENGLISH) & VIRTUAL CONSOLE'
echo 
sed -i '178s/.//' /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen
echo "KEYMAP=fr" >> /etc/vconsole.conf
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'SETTING UP THE HOST & ROOT PASSWORD (CHANGE root:"password")'
echo 
echo "archlinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archlinux.localdomain archlinux" >> /etc/hosts
echo root:password | chpasswd
sleep 2
echo
echo 'DONE!'
echo 

echo
echo "INSTALLING UEFI PKGS"
echo

PKGS=(
        # DISPLAY SERVER ------------------------------------------------------
        'xorg'
        # BOOTLOADER ----------------------------------------------------------
        'grub'
        #uncomment this if you've used btrfs as a filesystem
        #'grub-btrfs' 
        # NETWORK -------------------------------------------------------------
        'networkmanager'
        'network-manager-applet'
        'dialog'
        'wpa_supplicant'
        'reflector' 
        'avahi' 
        'nfs-utils' 
        'inetutils'
        'dnsutils' 
        'openbsd-netcat' 
        'iptables-nft' 
        'ipset'
        'nss-mdns'       
        # SECURITY ------------------------------------------------------------
        'openssh' 
        'firewalld' 
        # OTHER ---------------------------------------------------------------
        'mtools'            
        'dosfstools'        
        'xdg-user-dirs'
        'xdg-utils'
        'gvfs'
        'gvfs-smb' 
        'rsync'
        'flatpak' 
        'os-prober'
        'ntfs-3g'
        'fuseiso'
        'wget' 
        'curl'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    pacman -S "$PKG"
done

sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'INSTALLING GRUB BOOTLOADER'
echo 
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#UNCOMMENT these commands if you have another os to be used for dualboot
#echo "GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub"
#grub-mkconfig -o /boot/grub/grub.cfg

sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'ACTIVATING DEAMONS'
echo 
systemctl enable NetworkManager
systemctl enable firewalld
sleep 2
echo
echo 'DONE!'
echo 

echo
echo 'SETTING UP USER (CHANGE "username" & "password")'
echo 
useradd --create-home username
echo username:password | chpasswd
usermod -aG wheel,users,storage,lp,adm,optical username

# Optionnally Change 'User Name' to your Full Name
usermod -c 'User Name' username
echo "username ALL=(ALL) ALL" >> /etc/sudoers.d/username
sleep 2
echo
echo 'DONE!'
echo
echo -e '\033[1;32mReboot & login as the created user & run ./02-utils.sh\033[m'
echo