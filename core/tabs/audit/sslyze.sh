#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool sslyze || exit 1

echo ""
info "=== SSLyze Quick Reference ==="
info "Scan host:     sslyze <target>"
info "JSON output:   sslyze --json_out result.json <target>"
info "Check cert:    sslyze --certinfo <target>"
info "Check HSTS:    sslyze --hsts <target>"
info "Scan client:   sslyze --starttls <target>"
echo ""
