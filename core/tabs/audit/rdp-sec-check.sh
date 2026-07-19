#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== rdp-sec-check Quick Reference ==="
info "Download:  git clone https://github.com/CiscoCXSecurity/rdp-sec-check.git"
info "Run:       perl rdp-sec-check.pl <target>"
info "Port:      perl rdp-sec-check.pl <target>:<port>"
info "Verbose:   perl rdp-sec-check.pl -v <target>"
echo ""
