#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool grype || exit 1

echo ""
info "=== Grype Quick Reference ==="
info "Scan image:       grype <image_name>"
info "Scan archive:     grype docker-archive:<tar_path>"
info "Scan directory:   grype dir:<path>"
info "Output JSON:      grype <image> -o json"
info "Fail on high:     grype <image> --fail-on high"
info "Only fixed:       grype <image> --only-fixed"
echo ""
