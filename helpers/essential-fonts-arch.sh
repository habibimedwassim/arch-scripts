#!/usr/bin/env bash
# helpers/essential-fonts-arch.sh
# DESC: Install essential fonts on Arch Linux for maximum language coverage
#       and compatibility with Steam and Windows apps (via AUR packages).
#
# Usage: sudo ./helpers/essential-fonts-arch.sh
# If not run as root the script will use sudo where needed.

set -euo pipefail

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $*"; }
ok()   { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
err()  { echo -e "${RED}[ERR]${NC} $*"; }

is_root() { [[ $(id -u) -eq 0 ]]; }

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        err "Required command '$1' not found. Please install it and re-run."
        exit 1
    fi
}

detect_pkg_manager() {
    if command -v pacman >/dev/null 2>&1; then
        echo pacman
    else
        echo ""
    fi
}

# Packages to install from official repos (pacman)
pacman_pkgs=(
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    ttf-dejavu
    ttf-liberation
    ttf-ubuntu-font-family
    ttf-inconsolata
    ttf-fira-code
    ttf-jetbrains-mono
)

# Useful AUR packages (optional) — installed only if an AUR helper is available
aur_pkgs=(
    nerd-fonts-complete    # full patched nerd fonts (large)
    ttf-ms-win10           # Microsoft Windows 10 fonts for best compatibility (AUR)
    ttf-iosevka            # alternative monospaced font (optional)
)

INSTALL_PACMAN=()
INSTALL_AUR=()

install_pacman() {
    local pkgs=("${pacman_pkgs[@]}")

    # Filter out already-installed packages
    local to_install=()
    for p in "${pkgs[@]}"; do
        if pacman -Qs "^${p}($|\s)" >/dev/null 2>&1; then
            info "Package already present: $p"
        else
            to_install+=("$p")
        fi
    done

    if [ ${#to_install[@]} -eq 0 ]; then
        ok "All pacman packages already installed."
        return 0
    fi

    info "Installing pacman packages: ${to_install[*]}"
    if is_root; then
        pacman -S --needed --noconfirm "${to_install[@]}"
    else
        sudo pacman -S --needed --noconfirm "${to_install[@]}"
    fi
}

install_aur() {
    # Detect AUR helper (paru preferred, then yay)
    local helper=""
    if command -v paru >/dev/null 2>&1; then
        helper=paru
    elif command -v yay >/dev/null 2>&1; then
        helper=yay
    fi

    if [ -z "$helper" ]; then
        warn "No AUR helper (paru/yay) found. Skipping AUR packages."
        warn "To install AUR packages manually, install paru or yay and re-run, or use the provided list: ${aur_pkgs[*]}"
        return 0
    fi

    local to_install=()
    for p in "${aur_pkgs[@]}"; do
        if pacman -Qs "^${p}($|\s)" >/dev/null 2>&1 || pacman -Qm | grep -F "${p}" >/dev/null 2>&1; then
            info "AUR package already present: $p"
        else
            to_install+=("$p")
        fi
    done

    if [ ${#to_install[@]} -eq 0 ]; then
        ok "All AUR packages already installed."
        return 0
    fi

    info "Installing AUR packages with $helper: ${to_install[*]}"
    if [ "$helper" = "paru" ]; then
        $helper -S --needed --noconfirm "${to_install[@]}"
    else
        # yay handles non-root fine
        $helper -S --needed --noconfirm "${to_install[@]}"
    fi
}

main() {
    echo -e "\n${BLUE}===== Arch Essential Fonts Installer =====${NC}\n"

    # Check pacman
    if ! command -v pacman >/dev/null 2>&1; then
        err "This script requires 'pacman' and must be run on Arch Linux or an Arch-based distro."
        exit 1
    fi

    # Ensure sudo available when not running as root
    if ! is_root; then
        if ! command -v sudo >/dev/null 2>&1; then
            err "sudo is required to install packages. Please run as root or install sudo."
            exit 1
        fi
    fi

    info "Updating pacman database (accurate package checks)"
    if is_root; then
        pacman -Sy --noconfirm >/dev/null
    else
        sudo pacman -Sy --noconfirm >/dev/null
    fi

    install_pacman

    # Install AUR packages if possible
    install_aur

    info "Refreshing font cache (this can take a moment)"
    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f -v || true
    else
        warn "fc-cache not found; font cache may not have been updated."
    fi

    echo -e "\n${BLUE}====== Verification ======${NC}"
    # Show a few representative fonts installed
    echo -e "Installed font families (grep for common names):"
    fc-list : family | sed 's/,/\n/g' | sort -u | grep -Ei 'Noto|DejaVu|Liberation|Ubuntu|Fira|JetBrains|Iosevka|Nerd' || true

    echo -e "\n${BLUE}To verify full coverage you can run:${NC}"
    echo "  fc-list | grep -i noto"
    echo "  fc-list | grep -i 'microsoft\|ttf-ms'"

    echo -e "\n${GREEN}Installation complete. If you installed AUR packages and didn't have an AUR helper,\ninstall 'paru' or 'yay' and re-run the script to pick them up.${NC}"

    echo -e "\n${BLUE}Notes:${NC}"
    echo "- 'noto-fonts' + 'noto-fonts-cjk' + 'noto-fonts-emoji' provide coverage for most languages and emoji."
    echo "- 'ttf-ms-win10' (AUR) provides Windows compatibility for apps and Proton/Steam games."
    echo "- 'nerd-fonts-complete' (AUR) provides patched glyphs for terminals, editors, and prompts."
}

# Run main
main "$@"
