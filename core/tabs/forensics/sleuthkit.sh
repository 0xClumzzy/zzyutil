#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool sleuthkit || exit 1

echo ""
info "=== Sleuth Kit Quick Reference ==="
info "List files:            fls -o 2048 disk.dd"
info "List dirs:             fls -o 2048 -d disk.dd"
info "Recover file:          icat -o 2048 disk.dd <inode> > recovered.txt"
info "Partition table:       mmls disk.dd"
info "File stat:             istat -o 2048 disk.dd <inode>"
info "Timeline:              fls -o 2048 -m / -r disk.dd > body.txt"
info "                       mactime -b body.txt > timeline.csv"
echo ""
