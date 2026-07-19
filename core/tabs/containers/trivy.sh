#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool trivy || exit 1

echo ""
info "=== Trivy Quick Reference ==="
info "Scan image:          trivy image <image_name>"
info "Scan filesystem:     trivy fs <path>"
info "Scan repo:           trivy repo <git_url>"
info "Scan config:         trivy config <path>"
info "Ignore unfixed:      trivy image --ignore-unfixed <image>"
info "Output JSON:         trivy image -f json -o result.json <image>"
info "Severity filter:     trivy image --severity HIGH,CRITICAL <image>"
echo ""
