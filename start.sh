#!/bin/sh -eu

# Safer installer for zzyutil
# Features:
# - Architecture detection
# - Download to a secure tempfile with cleanup trap
# - Optional checksum verification (attempts to fetch <asset>.sha256 from the release)
# - Interactive confirmation when checksum cannot be verified
# - Optional --install mode to install the binary to /usr/local/bin (uses sudo if needed)
# - Optional --yes for non-interactive installs (will only proceed if checksum verification succeeds or --no-verify is provided)

rc='\033[0m'
red='\033[0;31m'
green='\033[0;32m'

echo_err() { printf '%s%s%s\n' "$red" "$1" "$rc" >&2; }
echo_ok() { printf '%s%s%s\n' "$green" "$1" "$rc"; }

check_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo_err "required command not found: $1"
        exit 1
    fi
}

# Detect architecture
find_arch() {
    case "$(uname -m)" in
        x86_64|amd64) arch="x86_64" ;;
        aarch64|arm64) arch="aarch64" ;;
        *) echo_err "Unsupported architecture: $(uname -m)"; exit 1 ;;
    esac
}

get_url() {
    if [ "${arch:-}" = "x86_64" ]; then
        echo "https://github.com/0xClumzzy/zzyutil/releases/latest/download/zzyutil"
    else
        echo "https://github.com/0xClumzzy/zzyutil/releases/latest/download/zzyutil-${arch}"
    fi
}

get_checksum_url() {
    echo "$(get_url).sha256"
}

usage() {
    cat <<EOF
Usage: $0 [--install] [--no-verify] [--yes] [--help] [-- <args>]

Options:
  --install     Install the downloaded binary to /usr/local/bin (will prompt for sudo if needed)
  --no-verify   Skip checksum verification (not recommended)
  --yes         Non-interactive: proceed without prompts. Will only install if checksum verification succeeds or --no-verify is explicitly provided.
  --help        Show this help message

By default the script downloads the release binary and runs it once from a secure temporary location.
EOF
}

# Flags
INSTALL=0
NO_VERIFY=0
YES=0

# Parse options (stop at --)
while [ "$#" -gt 0 ]; do
    case "$1" in
        --install) INSTALL=1; shift ;;
        --no-verify) NO_VERIFY=1; shift ;;
        --yes) YES=1; shift ;;
        --help) usage; exit 0 ;;
        --) shift; break ;;
        -*) echo_err "Unknown option: $1"; usage; exit 1 ;;
        *) break ;;
    esac
done

# remaining args are passed to the binary when executed
BINARY_ARGS="$@"

find_arch

# Require curl
check_cmd curl

WORKDIR=$(mktemp -d "zzyutil.XXXXXX")
trap 'rc=$?; rm -rf "${WORKDIR}" || true; exit "$rc"' EXIT

TMP_BIN="$WORKDIR/zzyutil.bin"

URL="$(get_url)"
CHK_URL="$(get_checksum_url)"

echo_ok "[*] Downloading zzyutil from $URL..."
if ! curl -fSL --retry 3 --retry-delay 2 "$URL" -o "$TMP_BIN"; then
    echo_err "Failed to download zzyutil from $URL"
    exit 1
fi
chmod 0755 "$TMP_BIN"

# Attempt checksum verification unless explicitly disabled
CHECKSUM_VERIFIED=0
if [ "$NO_VERIFY" -eq 0 ]; then
    echo_ok "[*] Attempting to download checksum from $CHK_URL"
    if curl -fSL "$CHK_URL" -o "$WORKDIR/checksum"; then
        # checksum file exists; verify
        EXPECTED=$(awk '{print $1}' "$WORKDIR/checksum")
        if command -v sha256sum >/dev/null 2>&1; then
            ACTUAL=$(sha256sum "$TMP_BIN" | awk '{print $1}')
        elif command -v shasum >/dev/null 2>&1; then
            ACTUAL=$(shasum -a 256 "$TMP_BIN" | awk '{print $1}')
        else
            echo_err "No sha256 verification tool found (sha256sum or shasum). Use --no-verify to skip verification."
            exit 1
        fi
        if [ "$EXPECTED" = "$ACTUAL" ]; then
            echo_ok "[+] Checksum verified"
            CHECKSUM_VERIFIED=1
        else
            echo_err "Checksum mismatch"
            exit 1
        fi
    else
        echo_err "No checksum file available at $CHK_URL"

        # If user explicitly requested --no-verify, allow proceeding without checksum
        if [ "$NO_VERIFY" -eq 1 ]; then
            echo_ok "[!] Proceeding without checksum verification because --no-verify was provided"
        else
            # For installs we never proceed without a checksum unless --no-verify is set
            if [ "$INSTALL" -eq 1 ]; then
                echo_err "Refusing to install without checksum verification. Use --no-verify to override."
                exit 1
            fi

            # In non-install mode, if --yes (non-interactive) is set, refuse to proceed without checksum
            if [ "$YES" -eq 1 ]; then
                echo_err "Non-interactive mode (--yes): refusing to proceed without checksum verification. Use --no-verify to override."
                exit 1
            fi

            # Interactive fallback: ask the user whether to run once from the temporary location
            printf '%sWARNING: Could not verify checksum for the downloaded binary.\nProceed to run it once from a temporary location? (y/N): %s' "$red" "$rc"
            read -r answer || true
            case "${answer}" in
                y|Y) echo_ok "User confirmed to run without verification" ;;
                *) echo_err "Aborting"; exit 1 ;;
            esac
        fi
    fi
else
    echo_ok "[!] Checksum verification disabled by user (--no-verify)"
fi

if [ "$INSTALL" -eq 1 ]; then
    DEST="/usr/local/bin/zzyutil"
    echo_ok "[*] Installing to $DEST"

    # Non-interactive safety: if --yes is provided and checksum verification was not performed, refuse
    if [ "$YES" -eq 1 ] && [ "$NO_VERIFY" -eq 0 ] && [ "$CHECKSUM_VERIFIED" -eq 0 ]; then
        echo_err "Non-interactive mode (--yes): refusing to install without a verified checksum. Use --no-verify to override."
        exit 1
    fi

    if [ -w "$(dirname "$DEST")" ]; then
        install -m 0755 "$TMP_BIN" "$DEST"
    else
        # Use sudo to install
        check_cmd sudo
        if [ "$YES" -eq 1 ]; then
            # Non-interactive sudo may fail if no tty or no cached credentials; still attempt
            sudo install -m 0755 "$TMP_BIN" "$DEST"
        else
            sudo install -m 0755 "$TMP_BIN" "$DEST"
        fi
    fi
    echo_ok "[+] Installed to $DEST"
    printf '%sYou can now run: %s zzyutil%s\n' "$green" "$rc" "$rc"
    exit 0
else
    echo_ok "[*] Running downloaded binary (temporary)"
    exec "$TMP_BIN" $BINARY_ARGS
fi
