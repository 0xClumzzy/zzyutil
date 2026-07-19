#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool xsstrike || exit 1

echo ""
info "=== XSStrike Quick Reference ==="
info "Scan path:         xsstrike -u \"http://target/page.php?q=foo\""
info "Crawl:             xsstrike -u \"http://target/page.php?q=foo\" --crawl"
info "Use blind:         xsstrike -u \"http://target/page.php?q=foo\" --blind"
info "Timeout:           xsstrike -u \"http://target/page.php?q=foo\" --timeout=10"
echo ""
