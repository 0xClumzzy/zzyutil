#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool mitmproxy || exit 1

echo ""
info "=== MITMProxy Quick Reference ==="
info "CLI:               mitmproxy -p 8080"
info "Web UI:            mitmweb -p 8080"
info "Transparent:       mitmproxy --mode transparent -p 8080"
info "Upstream:          mitmproxy --mode upstream:http://proxy:8080 -p 8080"
info "Script:            mitmproxy -s script.py"
echo ""
