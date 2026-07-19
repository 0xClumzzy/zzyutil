#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool snmpwalk || exit 1

echo ""
info "=== SNMPWalk Quick Reference ==="
info "Full walk:          snmpwalk -v2c -c public <target>"
info "Windows users:      snmpwalk -v2c -c public <target> 1.3.6.1.4.1.77.1.2.25"
info "Running processes:  snmpwalk -v2c -c public <target> 1.3.6.1.2.1.25.4.2.1.2"
info "Installed software: snmpwalk -v2c -c public <target> 1.3.6.1.2.1.25.6.3.1.2"
echo ""
