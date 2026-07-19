#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool remmina || exit 1

echo ""
info "=== Remmina Quick Reference ==="
info "Start GUI:      remmina"
info "RDP connect:    remmina -c rdp://<target>"
info "VNC connect:    remmina -c vnc://<target>"
info "SSH connect:    remmina -c ssh://<user>@<target>"
info "Profiles dir:   ~/.remmina/"
echo ""
