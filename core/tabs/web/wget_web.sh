#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool wget || exit 1

echo ""
info "=== Wget Quick Reference ==="
info "Download file:     wget http://target/file"
info "Mirror site:       wget -r -l 5 http://target"
info "With user agent:   wget -U \"Mozilla/5.0\" http://target"
info "No parent:         wget -r -np http://target/dir/"
info "Resume download:   wget -c http://target/file.iso"
echo ""
