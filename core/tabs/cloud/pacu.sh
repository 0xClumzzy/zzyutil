#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool pacu || exit 1

echo ""
info "=== Pacu Quick Reference ==="
info "Start console:        pacu"
info "List modules:         ls"
info "Run module:           run <module_name>"
info "Key modules:"
info "  iam__enum_users_roles_policies_groups"
info "  ec2__enum_latest_ami"
info "  s3__bucket_finder"
info "  lambda__list"
info "  privesc_scan"
echo ""
