#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool john || exit 1

echo ""
info "=== John the Ripper Quick Reference ==="
info "Basic crack:        john hash.txt"
info "With wordlist:      john --wordlist=wordlist.txt hash.txt"
info "Single mode:        john --single hash.txt"
info "Show results:       john --show hash.txt"
info "Incremental:        john --incremental hash.txt"
info "Unshadow:           unshadow passwd shadow > hash.txt"
echo ""
