#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== John to Hashcat Format Conversion ==="
info "Convert hash:       john --show hash.txt | cut -d: -f2 > hashcat.txt"
info "Win NTLM:           john --format=nt hash.txt --show | cut -d: -f2 > ntlm_hashcat.txt"
info "Use hashcat-mode:   hashcat -m 1000 -a 0 ntlm_hashcat.txt wordlist.txt"
echo ""
info "Tip: Use 'john --list=formats' to see all supported formats"
