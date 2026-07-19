#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool httpx || exit 1

echo ""
info "=== httpx Quick Reference ==="
info "Basic scan:        httpx http://target"
info "With output:       httpx -o output.txt http://target"
info "With ports:        httpx -ports 80,443,8080 http://target"
info "TLS probe:         httpx -tls http://target"
info "Extract all:       httpx -r http://target"
info "With threads:      httpx -threads 10 http://target"
echo ""
