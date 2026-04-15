#!/bin/bash

# DESIGN-OPS Installation Script
# Installs DESIGN-OPS using Claude Code's native plugin system
#
# Usage:
#   git clone https://github.com/opensesh/DESIGN-OPS
#   bash DESIGN-OPS/.design-ops/install.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory (where DESIGN-OPS source lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESIGN_OPS_ROOT="$(dirname "$SCRIPT_DIR")"

# Global directories
CLAUDE_DIR="$HOME/.claude"

echo
echo -e "${BLUE}╭──────────────────────────────────────────────────────────────╮${NC}"
echo -e "${BLUE}│  DESIGN-OPS Installation                                     │${NC}"
echo -e "${BLUE}╰──────────────────────────────────────────────────────────────╯${NC}"
echo

# Check if claude CLI is available
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: 'claude' CLI not found${NC}"
    echo "Please install Claude Code first: https://docs.anthropic.com/claude-code"
    exit 1
fi

# Register the marketplace
echo "Registering DESIGN-OPS marketplace..."
if claude plugin marketplace add "$DESIGN_OPS_ROOT" 2>/dev/null; then
    echo -e "${GREEN}  Marketplace registered${NC}"
else
    echo -e "${YELLOW}  Marketplace already registered or updated${NC}"
fi

# Install the plugin
echo "Installing DESIGN-OPS plugin..."
if claude plugin install design-ops@design-ops 2>/dev/null; then
    echo -e "${GREEN}  Plugin installed${NC}"
else
    # Try to reinstall if already present
    claude plugin uninstall design-ops@design-ops 2>/dev/null || true
    claude plugin install design-ops@design-ops
    echo -e "${GREEN}  Plugin reinstalled${NC}"
fi

# Update global CLAUDE.md
echo "Updating CLAUDE.md..."
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"

if [ -f "$CLAUDE_MD" ] && grep -q "<!-- DESIGN-OPS:START" "$CLAUDE_MD"; then
    echo -e "${YELLOW}  DESIGN-OPS section already in CLAUDE.md, skipping...${NC}"
else
    # Ensure CLAUDE.md exists
    mkdir -p "$CLAUDE_DIR"

    if [ -f "$CLAUDE_MD" ]; then
        echo "" >> "$CLAUDE_MD"
        echo "---" >> "$CLAUDE_MD"
        echo "" >> "$CLAUDE_MD"
    fi

    cat >> "$CLAUDE_MD" << 'EOF'
<!-- DESIGN-OPS:START - Do not edit between markers -->
## DESIGN-OPS

Global installation of [DESIGN-OPS](https://github.com/opensesh/DESIGN-OPS) for design team productivity.

### Quick Reference

- **Commands:** Type `/design-ops:` to see all commands
- **Setup:** `/design-ops:setup` — Configure integrations
- **Dashboard:** `/design-ops:dashboard` — Daily/weekly overview
- **Library:** `/design-ops:library` — Browse 14 utility commands
- **Help:** `/design-ops:help` — Full command reference

### Configuration

Config file: `~/.claude/design-ops-config.yaml`

Run `/design-ops:setup` for guided configuration.
<!-- DESIGN-OPS:END -->
EOF

    echo -e "${GREEN}  Added DESIGN-OPS section to CLAUDE.md${NC}"
fi

echo
echo -e "${GREEN}╭──────────────────────────────────────────────────────────────╮${NC}"
echo -e "${GREEN}│  Installation Complete!                                      │${NC}"
echo -e "${GREEN}╰──────────────────────────────────────────────────────────────╯${NC}"
echo
echo "DESIGN-OPS is now installed via Claude's plugin system."
echo
echo "Next steps:"
echo "  1. Start a new Claude Code session"
echo "  2. Run '/design-ops:setup' to configure your integrations"
echo "  3. Run '/design-ops:library' to explore utility commands"
echo "  4. Run '/design-ops:dashboard' for your daily overview"
echo
echo "For more information: https://github.com/opensesh/DESIGN-OPS"
echo
