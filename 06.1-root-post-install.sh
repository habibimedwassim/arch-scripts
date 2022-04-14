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
echo "MOUNTING SHARED PARTITION"
echo

#uncomment these lines if you've used 06.0-btrfs-specific.sh
#echo "MAX_SIZE=2048" >> /etc/default/zramd
#systemctl enable --now zramd.service

mkdir /usr/local/Data
echo "#Shared Partition" >> /etc/fstab
echo "/dev/sdb1  /usr/local/Data  ntfs-3g uid=1000,gid=1000,dmask=022,fmask=133 0 0" >> /etc/fstab
mount -a
echo "export QT_STYLE_OVERRIDE=kvantum" >> /etc/environment

echo
echo "Done!"
echo