#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool kube-bench || exit 1

echo ""
info "=== kube-bench Quick Reference ==="
info "Run all checks:  kube-bench run"
info "Run on node:     kube-bench run --targets master"
info "Run on worker:   kube-bench run --targets node"
info "JSON output:     kube-bench run --json"
info "Benchmark CIS:   kube-bench run --benchmark cis-1.8"
echo ""
