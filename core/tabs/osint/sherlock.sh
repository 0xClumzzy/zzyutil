#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool sherlock || exit 1

echo ""
info "=== Sherlock Quick Reference ==="
info "Search username:  sherlock <username>"
info "Output format:    sherlock --format json <username>"
info "Sites filter:     sherlock --site twitter,github <username>"
info "List sites:       sherlock --print-sites"
info "Tor routing:      sherlock --tor <username>"
echo ""
