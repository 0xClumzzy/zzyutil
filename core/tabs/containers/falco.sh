#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool falco || exit 1

echo ""
info "=== Falco Quick Reference ==="
info "Run falco:          sudo falco"
info "List rules:         falco --list"
info "Validate config:    falco --validate <config>"
info "Use custom rules:   sudo falco -r <rules_file>"
info "Output JSON:        sudo falco -o json"
echo ""
