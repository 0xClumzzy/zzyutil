#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool curl || exit 1

echo ""
info "=== cURL Quick Reference ==="
info "Get headers:       curl -I http://target"
info "Full response:     curl -v http://target"
info "With cookie:       curl -b \"session=abc\" http://target"
info "POST data:         curl -d \"user=admin&pass=test\" http://target/login"
info "Custom agent:      curl -A \"Mozilla/5.0\" http://target"
info "Follow redirects:  curl -L http://target"
info "Proxy:             curl -x http://proxy:8080 http://target"
echo ""
