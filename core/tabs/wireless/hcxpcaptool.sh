#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool hcxpcaptool || exit 1

echo ""
info "=== hcxpcaptool Quick Reference ==="
info "Convert to hashcat:     hcxpcaptool -z hashcat.hc22000 capture.pcapng"
info "Show info:              hcxpcaptool -i capture.pcapng"
info "All formats:            hcxpcaptool -E essidlist -I identitylist -U username capture.pcapng"
info "Hashcat mode 22000:     hashcat -m 22000 hashcat.hc22000 wordlist.txt"
echo ""
