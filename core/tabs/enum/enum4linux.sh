#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool enum4linux || exit 1

echo ""
info "=== enum4linux Quick Reference ==="
info "Full enum:      enum4linux -a <target>"
info "Users only:     enum4linux -U <target>"
info "Shares only:    enum4linux -S <target>"
info "OS info:        enum4linux -o <target>"
info "Group:          enum4linux -G <target>"
echo ""
