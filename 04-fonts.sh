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
echo "INSTALLING FONTS"
echo
                                
PKGS=(
        'ttf-liberation'
        'ttf-dejavu'
        'ttf-junicode'
        'gentium-plus-font'
        'ttf-droid'
        'ttf-hack'
        'ttf-monofur'
        'ttf-opensans'
        'inter-font'
        'cantarell-fonts'
        'noto-fonts-cjk'
        'noto-fonts-emoji'
        'adobe-source-han-serif-otc-fonts'
        'adobe-source-han-sans-otc-fonts'
        'adobe-source-code-pro-fonts'
        'ttf-linux-libertine'
        'ttf-jetbrains-mono'
        'ttf-inconsolata'
        'ttf-fira-code'
        'ttf-fira-mono'
        'ttf-fantasque-sans-mono'
        'ttf-cascadia-code'
        'tex-gyre-fonts'
        'ttf-roboto'
        'noto-fonts'
        'terminus-font'
        'ttf-ibm-plex'
        'dina-font'
        'tamsyn-font'
        'gnu-free-fonts'
        'ttf-anonymous-pro'
        'bdf-unifont'
        'ttf-ubuntu-font-family'
        'ttf-bitstream-vera'
        'ttf-croscore'
        'pop-fonts' 
        'ttf-meslo-nerd-font-powerlevel10k'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    yay -S "$PKG" --noconfirm
done

echo
echo 'DONE!'
echo -e '\033[1;32mRUN ./05.theming-configs.sh\033[m'
echo 
