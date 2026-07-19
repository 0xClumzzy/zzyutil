#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool dirsearch || exit 1

echo ""
info "=== Dirsearch Quick Reference ==="
info "Scan URL:      dirsearch -u http://target"
info "Extensions:    dirsearch -u http://target -e php,html,txt"
info "Wordlist:      dirsearch -u http://target -w /path/to/wordlist.txt"
info "Threads:       dirsearch -u http://target -t 50"
echo ""
