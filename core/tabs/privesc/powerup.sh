#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== PowerUp ==="
info "PowerShell tool for Windows privilege escalation."
info ""
info "Download:"
echo "  curl -LO https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1"
echo ""
info "Usage on target (PowerShell):"
echo "  PS> powershell -ep bypass"
echo "  PS> . .\\PowerUp.ps1"
echo "  PS> Invoke-AllChecks"
echo ""
    curl -L "https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1" -o /tmp/PowerUp.ps1 2>&1
    info "Downloaded to /tmp/PowerUp.ps1"
fi
