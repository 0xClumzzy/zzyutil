#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

echo ""
info "=== Unix Privesc Check ==="
info "Standard Unix privilege escalation checker script."
info ""
info "Download:"
echo "  curl -LO https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/master/unix-privesc-check.sh"
echo "  chmod +x unix-privesc-check.sh && ./unix-privesc-check.sh"
echo ""
    curl -L "https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/master/unix-privesc-check.sh" -o /tmp/unix-privesc-check.sh 2>&1
    chmod +x /tmp/unix-privesc-check.sh
    info "Downloaded to /tmp/unix-privesc-check.sh"
fi
