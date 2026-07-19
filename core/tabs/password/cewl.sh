#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool cewl || exit 1

echo ""
info "=== CeWL Quick Reference ==="
info "Generate list:     cewl http://target -w words.txt"
info "Min word length:   cewl http://target -m 6 -w words.txt"
info "With email:        cewl http://target -e -w words.txt"
info "Depth:             cewl http://target -d 3 -w words.txt"
echo ""
