#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool strings || exit 1

echo ""
info "=== strings (Reverse Engineering) ==="
info "Extract strings:        strings binary"
info "Min length:             strings -n 8 binary"
info "All encodings:          strings -a -e l binary"
info "Show offset:            strings -t x binary"
info "Unique only:            strings binary | sort -u"
info "Interesting:            strings binary | grep -E 'pass|key|secret|flag|http'"
echo ""
