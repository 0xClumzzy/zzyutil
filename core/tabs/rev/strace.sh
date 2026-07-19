#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool strace || exit 1

echo ""
info "=== strace Quick Reference ==="
info "Trace command:          strace ./binary"
info "Follow forks:           strace -f ./binary"
info "Show only files:        strace -e trace=file ./binary"
info "Show only network:      strace -e trace=network ./binary"
info "Stats summary:          strace -c ./binary"
info "Output to file:         strace -o trace.log ./binary"
info "PID attach:             strace -p <PID>"
info "Timestamps:             strace -t ./binary"
echo ""
