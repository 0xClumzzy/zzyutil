#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool nmap || exit 1

echo ""
info "=== Nmap Quick Reference ==="
info "Scan single host: nmap -sV -sC <target>"
info "Scan subnet:      nmap -sV -sC -O 192.168.1.0/24"
info "Fast scan:        nmap -T4 -F <target>"
info "All ports:        nmap -p- <target>"
info "Script scan:      nmap --script vuln <target>"
info "OS detection:     nmap -O <target>"
echo ""
