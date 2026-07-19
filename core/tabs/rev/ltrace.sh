#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool ltrace || exit 1

echo ""
info "=== ltrace Quick Reference ==="
info "Trace library calls:    ltrace ./binary"
info "Show all calls:         ltrace -a ./binary"
info "PID attach:             ltrace -p <PID>"
info "Summary:                ltrace -c ./binary"
info "Filter lib:             ltrace -e str* ./binary"
info "Output:                 ltrace -o trace.log ./binary"
echo ""
