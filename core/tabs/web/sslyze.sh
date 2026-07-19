#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool sslyze || exit 1

echo ""
info "=== SSLyze Quick Reference ==="
info "Scan host:         sslyze --regular target.com:443"
info "Cert info:         sslyze --certinfo target.com:443"
info "TLS 1.3 only:      sslyze --tls13 target.com:443"
info "JSON output:       sslyze --json_out report.json target.com:443"
echo ""
