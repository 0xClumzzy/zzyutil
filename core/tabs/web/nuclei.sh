#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool nuclei || exit 1

echo ""
info "=== Nuclei Quick Reference ==="
info "Basic scan:        nuclei -target http://target.com"
info "With templates:    nuclei -target http://target.com -t /path/to/templates/"
info "Output to file:    nuclei -target http://target.com -o results.json"
info "Silent mode:       nuclei -target http://target.com -silent"
info "Threads:           nuclei -target http://target.com -t /templates/ -c 50"
info "Exclude templates: nuclei -target http://target.com -exclude-templates "", ""]stdout to file:        nuclei -target http://target.com -o /tmp/results.txt"
info "Stop on first match: nuclei -target http://target.com -stop-at-first"
echo ""
