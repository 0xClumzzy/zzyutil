#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool evil-winrm || exit 1

echo ""
info "=== evil-winrm Quick Reference ==="
info "Connect:        evil-winrm -i <target> -u <user> -p <pass>"
info "Upload file:    evil-winrm -i <target> -u <user> -p <pass> -U <local_file>"
info "Download file:  evil-winrm -i <target> -u <user> -p <pass> -D <remote_path>"
info "With scripts:   evil-winrm -i <target> -u <user> -p <pass> -s <scripts_dir>"
info "PowerShell:     evil-winrm -i <target> -u <user> -p <pass> -e <ps1_file>"
echo ""
