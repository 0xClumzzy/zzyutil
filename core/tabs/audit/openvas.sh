#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool openvas || exit 1

echo ""
info "=== OpenVAS Quick Reference ==="
info "Full scan:        openvas -t <target>"
info "Quick scan:       openvas -q <target>"
info "Policy scan:      openvas -p <policy_id> <target>"
info "List targets:     openvas --list-targets"
info "List policies:    openvas --list-policies"
info "Start daemon:      openvasd -d"
info "Web UI:            https://localhost:9392"
info "Update feeds:      greenbone-feed-sync"
echo ""