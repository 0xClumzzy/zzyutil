#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool hashcat || exit 1

echo ""
info "=== Hashcat Quick Reference ==="
info "List modes:       hashcat --help | grep 'MD5\|SHA'"
info "MD5 dict:         hashcat -m 0 -a 0 hash.txt wordlist.txt"
info "SHA256 dict:      hashcat -m 1400 -a 0 hash.txt wordlist.txt"
info "NTLM dict:        hashcat -m 1000 -a 0 hash.txt wordlist.txt"
info "WPA handshake:    hashcat -m 22000 handshake.hccapx wordlist.txt"
info "Brute force:      hashcat -m 0 -a 3 hash.txt ?a?a?a?a?a?a"
info "Show cracked:     hashcat -m 0 hash.txt --show"
echo ""
