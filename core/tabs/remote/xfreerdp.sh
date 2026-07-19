#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool xfreerdp || exit 1

echo ""
info "=== xfreerdp Quick Reference ==="
info "Connect:        xfreerdp /v:<target> /u:<user>"
info "With password:  xfreerdp /v:<target> /u:<user> /p:<pass>"
info "Full screen:    xfreerdp /v:<target> /u:<user> /f"
info "Shared drive:   xfreerdp /v:<target> /u:<user> /drive:share,<path>"
info "Clipboard:      xfreerdp /v:<target> /u:<user> +clipboard"
info "Cert ignore:    xfreerdp /v:<target> /u:<user> /cert:ignore"
echo ""
