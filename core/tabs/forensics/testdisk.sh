#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool testdisk || exit 1

echo ""
info "=== TestDisk Quick Reference ==="
info "Launch TestDisk:       testdisk"
info "PhotoRec (file recov): photorec"
info "Creates log file to track recovery actions"
info "Useful for recovering deleted partitions and files"
echo ""
