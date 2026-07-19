#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool medusa || exit 1

echo ""
info "=== Medusa Quick Reference ==="
info "SSH brute:         medusa -h target -u user -P pass.txt -M ssh"
info "HTTP brute:        medusa -h target -u admin -P pass.txt -M http -m DIR:/login.php"
info "FTP brute:         medusa -h target -u user -P pass.txt -M ftp"
info "SMB brute:         medusa -h target -u user -P pass.txt -M smbnt"
echo ""
