#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool Invoke-MicroBurst || exit 1

echo ""
info "=== MicroBurst Quick Reference ==="
info "Import module:     Import-Module .\MicroBurst.psm1"
info "enumerate Azure:   Invoke-EnumerateAzureSubDomains -Domain <domain>"
info "check roles:       Invoke-EnumerateAzureRBAC"
info "key vault:         Invoke-EnumerateAzureKeyVault -Wordlist <file>"
echo ""
