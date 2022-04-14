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
        # DEVELOPMENT ---------------------------------------------------------             
        'jdk8-openjdk' 
        'postman-bin'
        'visual-studio-code-bin'
        'mongodb-bin'
        'mongodb-compass'
        'mongodb-tools-bin'
        'docker'
        'docker-compose'
        'apache'                
        'clang'                 
        'cmake'                             
        'git'                   
        'gcc'                   
        'glibc'                 
        'mariadb'               
        'meld'                  
        'nodejs-lts-gallium'                
        'npm'                   
        'php'                   
        'php-apache'            
        'postfix'
        'python'               
        'python-pip'
        'filezilla'
        'glances'
        # GRAPHICS AND DESIGN -------------------------------------------------
        'gcolor3'        
        'gimp'              
        'inkscape'             
        'imagemagick'     
        'nomacs'            
        'pngcrush'
        'blender'
        'darktable'
        'digikam'
        'krita'
                                  

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG"
done

echo
echo 'ACTIVATING DEAMONS'
echo 
sudo systemctl enable --now mongodb.service
sudo systemctl enable --now docker.service
sleep 2

echo
echo 'DONE!'
echo -e '\033[1;32mRUN ./07.2.common-tools.sh\033[m'
echo 
