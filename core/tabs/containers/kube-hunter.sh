#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool kube-hunter || exit 1

echo ""
info "=== kube-hunter Quick Reference ==="
info "Scan local:         kube-hunter"
info "Scan remote:        kube-hunter --remote <ip>"
info "Active mode:        kube-hunter --active"
info "Specific subnet:    kube-hunter --cidr <cidr>"
info "Report JSON:        kube-hunter --report json"
echo ""
