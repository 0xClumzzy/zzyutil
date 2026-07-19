#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool dockle || exit 1

echo ""
info "=== Dockle Quick Reference ==="
info "Scan image:     dockle <image_name>"
info "Ignore rules:   dockle --ignore CIS-DI-0001 <image>"
info "Exit code:      dockle --exit-code 1 <image>"
info "Report format:  dockle -f json -o report.json <image>"
echo ""
