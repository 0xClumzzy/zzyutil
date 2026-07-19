#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool spiderfoot || exit 1

echo ""
info "=== SpiderFoot Quick Reference ==="
info "Start web UI:    spiderfoot -l 127.0.0.1:5001"
info "CLI scan:        spiderfoot -s <target> -m sfp_dnsresolve"
info "Full scan:       spiderfoot -s <target> -t DOMAIN_NAME"
info "List modules:    spiderfoot -M"
echo ""
