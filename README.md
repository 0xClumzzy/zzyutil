# ZZYUTIL — Cybersecurity Toolbox

A terminal UI that organizes and runs cybersecurity tools from a browsable catalog. Inspired by Black Arch, built on Ratatui.

<img width="1793" height="891" alt="image" src="https://github.com/user-attachments/assets/e8b96c1c-b184-43e2-8272-ea73f660f24a" />

## Features

- **50+ pentesting tools** organized by category
- **Beautiful TUI** with 3 themes (dark, compatible, cyber)
- **Auto-install** missing tools via pacman, apt, paru, yay
- **Interactive execution** with live output display
- **Search & filter** tools by name
- **Show only installed** tools
- **Multi-select** and batch execution
- **Precondition checks** for tool availability
- **Cross-platform** — works on any Linux distro with AUR helper support

## Installation

### One-liner (recommended)

```bash
curl -fSL -o zzyutil "https://github.com/0xClumzzy/zzyutil/releases/latest/download/zzyutil" && curl -fSL -o zzyutil.sha256 "https://github.com/0xClumzzy/zzyutil/releases/latest/download/zzyutil.sha256" && sha256sum -c zzyutil.sha256 && chmod +x zzyutil && sudo install -m 0755 zzyutil /usr/local/bin/zzyutil
```

### Manual install

```bash
# Download binary and checksum
curl -fSL -o zzyutil "https://github.com/0xClumzzy/zzyutil/releases/latest/download/zzyutil"
curl -fSL -o zzyutil.sha256 "https://github.com/0xClumzzy/zzyutil/releases/latest/download/zzyutil.sha256"

# Verify and install
sha256sum -c zzyutil.sha256
chmod +x zzyutil
sudo install -m 0755 zzyutil /usr/local/bin/zzyutil
```

### Build from source

```bash
git clone https://github.com/0xClumzzy/zzyutil.git
cd zzyutil
cargo build --release
```

Binary will be at `target/release/zzyutil`.

## Usage

```bash
# Run with default dark theme
zzyutil

# Run with cyber green theme
zzyutil --theme cyber

# Run with compatible (simple) theme
zzyutil --theme compatible

# Enable mouse support
zzyutil --theme cyber --mouse

# Override validation (show all tools even if dependencies missing)
zzyutil --override-validation
```

### CLI Options

| Option | Description | Default |
|--------|-------------|---------|
| `--theme` | Theme: `dark`, `compatible`, `cyber` | `dark` |
| `--mouse` | Enable mouse support | `false` |
| `--config` | Path to config file | — |
| `--skip-confirmation` | Skip install confirmation | `false` |
| `--override-validation` | Show all tools regardless of dependencies | `false` |
| `--size-bypass` | Bypass terminal size check | `false` |

With passwordless sudo (required for auto-install):

```bash
sudo zzyutil --theme cyber
```

## Navigation

| Key | Action |
|-----|--------|
| `Tab` / `BackTab` | Switch between tab list and command tree |
| `↑` / `↓` or `k` / `j` | Navigate entries |
| `Enter` or `l` / `Right` | Run selected command / enter directory |
| `Backspace` or `h` / `Left` | Go back to parent / focus tab list |
| `d` | Show description |
| `v` | Toggle multi-select mode |
| `Space` | Toggle selection (in multi-select mode) |
| `i` | Toggle installed-only filter |
| `/` | Search |
| `Esc` / `q` | Go back / quit |

### Multi-select

1. Press `v` to enter multi-select mode
2. Use `Space` to select/deselect tools
3. Press `Enter` to confirm and batch-execute all selected tools

## Themes

| Theme | Description |
|-------|-------------|
| `dark` | Dark red/black theme (default) |
| `compatible` | Simple high-contrast theme for terminals with limited color support |
| `cyber` | Cyber green/hacker aesthetic |

## Tool Categories

### Reconnaissance
Network discovery, port scanning, and OSINT gathering.
- **Port Scanning**: Nmap, RustScan, Masscan
- **DNS Discovery**: Subfinder, Amass, dnsrecon, dnsenum
- **OSINT**: theHarvester, Recon-ng

### Enumeration
Service and application enumeration.
- **Web**: Gobuster, ffuf, Dirsearch, Wfuzz
- **Network**: Enum4linux, SNMPwalk, SMBclient, Netcat
- **Web Scanning**: Nikto

### Exploitation
Vulnerability exploitation and payload generation.
- **Framework**: Metasploit, MSFVenom
- **Web Exploitation**: SQLMap, Commix, XSStrike
- **Search**: SearchSploit
- **Binary**: Shellter

### Web
Web application testing and analysis.
- **Scanning**: Nuclei, Nikto, WPScan
- **Discovery**: HTTPx, WhatWeb, Dirb
- **Analysis**: SSlyze, cURL, Wget

### Password Attacks
Password cracking and brute-force attacks.

### Post-Exploitation
Post-exploitation tools for persistence and lateral movement.

### Forensics
Digital forensics and file analysis.

### Wireless
Wireless network auditing and attacks.

### Reverse Engineering
Binary analysis and reverse engineering tools.

### Privilege Escalation
Linux privilege escalation tools and techniques.

## Architecture

```
zzyutil/
├── Cargo.toml           # Workspace configuration
├── core/                # Core library crate
│   ├── Cargo.toml
│   ├── src/
│   │   ├── lib.rs       # Public types: Catalog, Tab, ListNode, Command
│   │   ├── inner.rs     # Catalog loading, tree building, precondition evaluation
│   │   └── config.rs    # TOML config parsing
│   └── tabs/            # Embedded tool definitions
│       ├── tabs.toml    # Tab directory registry
│       ├── common-script.sh  # Shared installer script
│       ├── recon/       # Reconnaissance tools
│       ├── enum/        # Enumeration tools
│       ├── exploit/     # Exploitation tools
│       ├── web/         # Web testing tools
│       ├── password/    # Password attack tools
│       ├── post-exploit/# Post-exploitation tools
│       ├── forensics/   # Forensics tools
│       ├── wireless/    # Wireless tools
│       ├── rev/         # Reverse engineering tools
│       └── privesc/     # Privilege escalation tools
└── tui/                 # Terminal UI binary crate
    ├── Cargo.toml
    └── src/
        ├── main.rs      # Application entry point, event loop
        ├── state.rs     # AppState, navigation, rendering
        ├── cli.rs       # CLI argument parsing (clap)
        ├── theme.rs     # Theme definitions (Dark, Compatible, Cyber)
        ├── filter.rs    # Search/filter functionality
        ├── float.rs     # Floating popup windows
        ├── hint.rs      # Keyboard shortcut hints
        └── banner.rs    # ASCII art banner
```

### How It Works

1. **Catalog Loading**: On startup, `core` extracts embedded shell scripts to a temp directory
2. **Precondition Checks**: Each tool entry has optional preconditions (command exists, file exists, env vars)
3. **Tree Building**: Tools are organized into a tree structure per category tab
4. **TUI Rendering**: Ratatui renders the interactive interface with real-time keyboard input
5. **Execution**: Selected tools are executed via `sh -c` with live output capture

### Key Dependencies

| Crate | Purpose |
|-------|---------|
| `ratatui` | Terminal UI framework |
| `crossterm` | Terminal input/output handling |
| `clap` | CLI argument parsing |
| `ego-tree` | Tree data structure for tool hierarchy |
| `include_dir` | Embed tab scripts at compile time |
| `temp-dir` | Temporary directory management |
| `serde` / `toml` | Configuration parsing |

## Adding Custom Tools

Each tool category has a `tab_data.toml` and associated shell scripts:

```toml
# core/tabs/newcategory/tab_data.toml
name = "My Category"

[[data]]
name = "Subcategory"
description = "Description of subcategory"

[[data.entries]]
name = "My Tool"
description = "What the tool does"
script = "mytool.sh"
task_list = "I R"
multi_select = false
```

The installer script (`common-script.sh`) handles package installation via system package managers.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development

```bash
# Run in development
cargo run

# Run with specific theme
cargo run -- --theme cyber

# Run tests
cargo test
```

## License

MIT License — see [LICENSE](LICENSE) for details.

---

Made by [0xClumzZy](https://github.com/0xClumzzy)
