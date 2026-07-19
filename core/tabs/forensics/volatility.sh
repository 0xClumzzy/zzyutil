#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool volatility3 || exit 1

echo ""
info "=== Volatility Quick Reference ==="
info "Image info:          vol -f memory.dump imageinfo"
info "Process list:        vol -f memory.dump --profile=Win10x64 pslist"
info "CMD history:         vol -f memory.dump --profile=Win10x64 cmdline"
info "Network (old):       vol -f memory.dump --profile=Win10x64 netscan"
info "Dump process:        vol -f memory.dump --profile=Win10x64 memdump -p <PID> -D /tmp/"
info "Hashdump:            vol -f memory.dump --profile=Win10x64 hashdump"
echo ""
