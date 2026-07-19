#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== LSE (Linux Smart Enumeration) ==="
info "Linux security enumeration script."
info "Levels: lvl1 (basic), lvl2 (recommended), lvl3 (extensive)"
echo ""
info "Quick run:"
echo "  curl "https://github.com/diego-treitos/linux-smart-enumeration/releases/latest/download/lse.sh" -Lo lse.sh;chmod 700 lse.sh"
echo ""
    curl "https://github.com/diego-treitos/linux-smart-enumeration/releases/latest/download/lse.sh" -Lo lse.sh;chmod 700 lse.sh
    info "Downloaded to lse.sh"
fi
