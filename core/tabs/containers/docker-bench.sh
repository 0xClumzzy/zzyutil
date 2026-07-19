#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool docker-bench || exit 1

echo ""
info "=== Docker Bench Quick Reference ==="
info "Run all checks:     docker-bench"
info "Check specific:     docker-bench -t 1.1"
info "Exclude checks:     docker-bench -e 1.1.1"
info "JSON output:        docker-bench -l /tmp/results"
echo ""
