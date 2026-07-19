#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool cloudsploit || exit 1

echo ""
info "=== CloudSploit Quick Reference ==="
info "Scan AWS:      cloudsploit scan --config config.json"
info "Plugins list:  cloudsploit plugins"
info "Default scan:  cloudsploit scan"
info "Custom config: cloudsploit scan -c config.json"
echo ""
