#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool whatweb || exit 1

echo ""
info "=== WhatWeb Quick Reference ==="
info "Basic scan:        whatweb http://target"
info "Aggressive:        whatweb -a 3 http://target"
info "Verbose:           whatweb -v http://target"
info "No errors:         whatweb --no-errors http://target"
info "Multiple targets:  whatweb http://target1 http://target2"
echo ""
