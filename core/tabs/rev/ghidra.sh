#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool java || exit 1

echo ""
info "=== Ghidra Quick Reference ==="
info "Launch GUI:           ghidraRun"
info "Analyze:              File > Open Project > Analyze"
info "Auto-analysis:        Analyze > Auto Analyze"
info "Decompile:            Window > Decompiler"
info "Scripting:            Window > Script Manager"
info "Search:               Edit > Find in Program"
info "Diff:                 Compare > Compare Two Programs"
info "Headless analysis:    analyzeHeadless <project> <project_name> -import <file>"
info "Java required:        ghidra runs on JVM"
echo ""