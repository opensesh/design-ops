#!/bin/bash

# DESIGN-OPS Installation Script
# Installs DESIGN-OPS globally to ~/.claude/
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

# Global installation directory
CLAUDE_DIR="$HOME/.claude"
PLUGIN_DIR="$CLAUDE_DIR/plugins/design-ops"

echo
echo -e "${BLUE}╭──────────────────────────────────────────────────────────────╮${NC}"
echo -e "${BLUE}│  DESIGN-OPS Installation                                     │${NC}"
echo -e "${BLUE}╰──────────────────────────────────────────────────────────────╯${NC}"
echo

# Check for existing installation
if [ -d "$PLUGIN_DIR" ]; then
    echo -e "${YELLOW}DESIGN-OPS is already installed at $PLUGIN_DIR${NC}"
    read -p "Overwrite existing installation? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
    rm -rf "$PLUGIN_DIR"
fi

echo -e "${GREEN}Installing DESIGN-OPS to: $PLUGIN_DIR${NC}"
echo

# Create directory structure
echo "Creating directories..."
mkdir -p "$PLUGIN_DIR/commands/library/logistics"
mkdir -p "$PLUGIN_DIR/commands/library/content"
mkdir -p "$PLUGIN_DIR/commands/library/development"
mkdir -p "$PLUGIN_DIR/commands/library/design"
mkdir -p "$PLUGIN_DIR/skills"
mkdir -p "$PLUGIN_DIR/references"
mkdir -p "$PLUGIN_DIR/templates"
mkdir -p "$PLUGIN_DIR/.claude-plugin"

# Copy main commands
echo "Copying commands..."
COMMAND_COUNT=0
for cmd in "$DESIGN_OPS_ROOT"/commands/*.md; do
    if [ -f "$cmd" ]; then
        cp "$cmd" "$PLUGIN_DIR/commands/"
        COMMAND_COUNT=$((COMMAND_COUNT + 1))
    fi
done
echo "  Copied $COMMAND_COUNT main commands"

# Copy library commands
echo "Copying library commands..."
LIBRARY_COUNT=0

# Logistics
for cmd in "$DESIGN_OPS_ROOT"/commands/library/logistics/*.md; do
    if [ -f "$cmd" ]; then
        cp "$cmd" "$PLUGIN_DIR/commands/library/logistics/"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    fi
done

# Content
for cmd in "$DESIGN_OPS_ROOT"/commands/library/content/*.md; do
    if [ -f "$cmd" ]; then
        cp "$cmd" "$PLUGIN_DIR/commands/library/content/"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    fi
done

# Development
for cmd in "$DESIGN_OPS_ROOT"/commands/library/development/*.md; do
    if [ -f "$cmd" ]; then
        cp "$cmd" "$PLUGIN_DIR/commands/library/development/"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    fi
done

# Design
for cmd in "$DESIGN_OPS_ROOT"/commands/library/design/*.md; do
    if [ -f "$cmd" ]; then
        cp "$cmd" "$PLUGIN_DIR/commands/library/design/"
        LIBRARY_COUNT=$((LIBRARY_COUNT + 1))
    fi
done

# Copy registry
cp "$DESIGN_OPS_ROOT/commands/library/_registry.yaml" "$PLUGIN_DIR/commands/library/"

echo "  Copied $LIBRARY_COUNT library commands"

# Copy skills
echo "Copying skills..."
SKILL_COUNT=0
for skill in "$DESIGN_OPS_ROOT"/skills/*.md; do
    if [ -f "$skill" ]; then
        cp "$skill" "$PLUGIN_DIR/skills/"
        SKILL_COUNT=$((SKILL_COUNT + 1))
    fi
done

# Copy skill directories (brand-guidelines, frontend-design, etc.)
for skill_dir in "$DESIGN_OPS_ROOT"/skills/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        mkdir -p "$PLUGIN_DIR/skills/$skill_name"
        cp -r "$skill_dir"* "$PLUGIN_DIR/skills/$skill_name/" 2>/dev/null || true
        SKILL_COUNT=$((SKILL_COUNT + 1))
    fi
done
echo "  Copied $SKILL_COUNT skills"

# Copy references
echo "Copying references..."
cp -r "$DESIGN_OPS_ROOT/references/"* "$PLUGIN_DIR/references/" 2>/dev/null || true

# Copy templates
echo "Copying templates..."
cp -r "$DESIGN_OPS_ROOT/templates/"* "$PLUGIN_DIR/templates/" 2>/dev/null || true

# Copy plugin manifest
echo "Copying plugin manifest..."
cp "$DESIGN_OPS_ROOT/.claude-plugin/plugin.json" "$PLUGIN_DIR/.claude-plugin/"

# Copy README
cp "$DESIGN_OPS_ROOT/README.md" "$PLUGIN_DIR/"

# Update global CLAUDE.md
echo "Updating CLAUDE.md..."
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"

if [ -f "$CLAUDE_MD" ] && grep -q "<!-- DESIGN-OPS:START" "$CLAUDE_MD"; then
    echo -e "${YELLOW}DESIGN-OPS section already in CLAUDE.md, skipping...${NC}"
else
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

    echo "  Added DESIGN-OPS section to CLAUDE.md"
fi

echo
echo -e "${GREEN}╭──────────────────────────────────────────────────────────────╮${NC}"
echo -e "${GREEN}│  Installation Complete!                                      │${NC}"
echo -e "${GREEN}╰──────────────────────────────────────────────────────────────╯${NC}"
echo
echo "Installed to: $PLUGIN_DIR"
echo
echo "  commands/           $COMMAND_COUNT main commands"
echo "  commands/library/   $LIBRARY_COUNT utility commands"
echo "  skills/             $SKILL_COUNT skills"
echo "  references/         Documentation"
echo "  templates/          Config templates"
echo
echo "Next steps:"
echo "  1. Run '/design-ops:setup' to configure your integrations"
echo "  2. Run '/design-ops:library' to explore utility commands"
echo "  3. Run '/design-ops:dashboard' for your daily overview"
echo
echo "For more information: https://github.com/opensesh/DESIGN-OPS"
