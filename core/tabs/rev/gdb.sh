#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/../common-script.sh"

ensure_tool gdb || exit 1

echo ""
info "=== GDB Quick Reference ==="
info "Launch:                 gdb ./binary"
info "Run:                    run (or r)"
info "Disassemble:            disassemble main"
info "Breakpoint:             break *main+42"
info "Break at func:         break function_name"
info "Continue:               continue (or c)"
info "Step:                   stepi (si)"
info "Next:                   nexti (ni)"
info "Registers:              info registers"
info "Stack:                  backtrace (bt)"
info "Memory:                 x/32xw $rsp"
echo ""
info "Plugins:                pwndbg (pip install pwndbg)"
info "                        peda (git clone https://github.com/longld/peda)"
info "                        gef (bash -c \"\$(curl -fsSL https://gef.sh)\")"
echo ""
