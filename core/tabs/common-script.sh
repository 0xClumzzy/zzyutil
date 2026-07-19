#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info() { printf "${CYAN}[*]${NC} %s\n" "$1"; }
success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
warn() { printf "${YELLOW}[!]${NC} %s\n" "$1"; }
error() { printf "${RED}[-]${NC} %s\n" "$1"; }

DISTRO="unknown"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO="$ID"
elif command -v lsb_release >/dev/null 2>&1; then
    DISTRO=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
fi

PACKAGER="none"
AUR_HELPER=""
for pm in pacman apt dnf yum zypper emerge xbps-install; do
    if command -v "$pm" >/dev/null 2>&1; then
        PACKAGER="$pm"
        break
    fi
done

if [ "$PACKAGER" = "pacman" ]; then
    for aur in yay paru trizen aura pikaur pamac-aur; do
        if command -v "$aur" >/dev/null 2>&1; then
            AUR_HELPER="$aur"
            break
        fi
    done
fi

ESCALATION=""
for tool in sudo doas; do
    if command -v "$tool" >/dev/null 2>&1; then
        ESCALATION="$tool"
        break
    fi
done

case "$PACKAGER" in
    pacman) INSTALL_CMD="$ESCALATION pacman -S --noconfirm" ;;
    apt)    INSTALL_CMD="$ESCALATION apt install -y" ;;
    dnf)    INSTALL_CMD="$ESCALATION dnf install -y" ;;
    yum)    INSTALL_CMD="$ESCALATION yum install -y" ;;
    zypper) INSTALL_CMD="$ESCALATION zypper install -y" ;;
    emerge) INSTALL_CMD="$ESCALATION emerge --ask=n" ;;
    xbps-install) INSTALL_CMD="$ESCALATION xbps-install -y" ;;
    *)      INSTALL_CMD="" ;;
esac

install_package() {
    local pkg="${1:-}"
    if [ -z "$pkg" ]; then
        error "No package specified."
        return 1
    fi
    if [ -z "$INSTALL_CMD" ]; then
        if [ -n "$AUR_HELPER" ]; then
            info "No official package manager. Trying AUR via $AUR_HELPER..."
            "$AUR_HELPER" -S --noconfirm "$pkg" 2>&1 || {
                error "Failed to install $pkg from AUR"
                return 1
            }
            success "$pkg"
            return 0
        fi
        error "No package manager found. Install $pkg manually."
        return 1
    fi
    if [ -n "$ESCALATION" ]; then
        $ESCALATION -n true 2>/dev/null || {
            if [ -n "$AUR_HELPER" ]; then
                info "No passwordless sudo. Trying AUR via $AUR_HELPER..."
                "$AUR_HELPER" -S --noconfirm "$pkg" 2>&1 || {
                    error "Failed to install $pkg"
                    return 1
                }
                success "$pkg"
                return 0
            fi
            warn "Passwordless sudo/doas not available."
            warn "Run with: sudo zzyutil"
            warn "Or install manually: $INSTALL_CMD $pkg"
            return 1
        }
    fi
    case "$PACKAGER" in
        pacman)      $ESCALATION pacman -S --noconfirm --needed "$pkg" 2>&1 ;;
        apt)         $ESCALATION apt install -y "$pkg" 2>&1 ;;
        dnf)         $ESCALATION dnf install -y "$pkg" 2>&1 ;;
        yum)         $ESCALATION yum install -y "$pkg" 2>&1 ;;
        zypper)      $ESCALATION zypper install -y "$pkg" 2>&1 ;;
        emerge)      $ESCALATION emerge --ask=n "$pkg" 2>&1 ;;
        xbps-install) $ESCALATION xbps-install -y "$pkg" 2>&1 ;;
        *)           error "Unknown package manager: $PACKAGER"; return 1 ;;
    esac || {
        if [ -n "$AUR_HELPER" ]; then
            warn "Package $pkg not found in official repos. Trying AUR..."
            "$AUR_HELPER" -S --noconfirm "$pkg" 2>&1 || {
                error "Failed to install $pkg from AUR"
                return 1
            }
            success "$pkg"
            return 0
        fi
        error "Failed to install $pkg"
        return 1
    }
    success "$pkg"
}

install_aur() {
    local pkg="${1:-}"
    if [ -z "$pkg" ]; then
        error "No package specified."
        return 1
    fi
    if [ "$PACKAGER" != "pacman" ]; then
        error "AUR packages are only available on Arch Linux."
        return 1
    fi
    if [ -z "$AUR_HELPER" ]; then
        error "No AUR helper found. Install yay, paru, or another AUR helper."
        warn "Install paru: git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si"
        return 1
    fi
    info "Installing $pkg from AUR via $AUR_HELPER..."
    "$AUR_HELPER" -S --noconfirm "$pkg" 2>&1 || {
        error "Failed to install $pkg from AUR"
        return 1
    }
    success "$pkg"
}

ensure_tool() {
    local tool="$1"
    local pkg="${2:-$1}"
    if ! command -v "$tool" >/dev/null 2>&1; then
        warn "$tool not found. Attempting install..."
        if [ "$PACKAGER" = "pacman" ] && [ -n "$AUR_HELPER" ]; then
            case "$tool" in
                msfconsole|msfvenom) pkg="metasploit" ;;
                smbclient) pkg="samba" ;;
                wireshark) pkg="wireshark-cli" ;;
                responder) pkg="responder" ;;
                proxychains) pkg="proxychains-ng" ;;
                enum4linux) pkg="enum4linux-ng" ;;
                volatility3) pkg="volatility3" ;;
                hcxdumptool) pkg="hcxdumptool" ;;
                airmon-ng) pkg="aircrack-ng" ;;
                reaver) pkg="reaver" ;;
            esac
        fi
        install_package "$pkg" || return 1
    fi
    return 0
}
