#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool amass || exit 1

echo ""
info "=== Amass Quick Reference ==="
info "Enum domain:   amass enum -d example.com"
info "Passive:       amass enum -passive -d example.com"
info "With output:   amass enum -d example.com -o dir/"
info "Intel:         amass intel -whois -d example.com"
echo ""
