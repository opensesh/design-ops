#!/bin/bash

# DESIGN-OPS Update Script
# Pulls the latest changes and reinstalls the plugin
#
# Usage (run from anywhere):
#   design-ops-update
#   -- OR --
#   bash ~/.claude/design-ops/.design-ops/update.sh
#
# The script automatically finds your DESIGN-OPS installation.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Metadata location (set during install)
CLAUDE_DIR="$HOME/.claude"
DESIGN_OPS_META_DIR="$CLAUDE_DIR/design-ops"
SOURCE_PATH_FILE="$DESIGN_OPS_META_DIR/.source-path"

echo
echo -e "${BLUE}╭──────────────────────────────────────────────────────────────╮${NC}"
echo -e "${BLUE}│  DESIGN-OPS Update                                           │${NC}"
echo -e "${BLUE}╰──────────────────────────────────────────────────────────────╯${NC}"
echo

# Find DESIGN-OPS source directory
find_source_dir() {
    # Method 1: Check saved source path from install
    if [ -f "$SOURCE_PATH_FILE" ]; then
        local saved_path
        saved_path=$(cat "$SOURCE_PATH_FILE")
        if [ -d "$saved_path/.git" ]; then
            echo "$saved_path"
            return 0
        fi
    fi

    # Method 2: Check if we're being run from the source directory
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
    local potential_root
    potential_root="$(dirname "$script_dir")"
    if [ -d "$potential_root/.git" ] && [ -f "$potential_root/.claude-plugin/plugin.json" ]; then
        echo "$potential_root"
        return 0
    fi

    # Method 3: Check common locations
    local common_locations=(
        "$HOME/DESIGN-OPS"
        "$HOME/Documents/DESIGN-OPS"
        "$HOME/Documents/GitHub/DESIGN-OPS"
        "$HOME/Documents/GitHub.nosync/DESIGN-OPS"
        "$HOME/Projects/DESIGN-OPS"
        "$HOME/Code/DESIGN-OPS"
        "$HOME/dev/DESIGN-OPS"
    )

    for loc in "${common_locations[@]}"; do
        if [ -d "$loc/.git" ] && [ -f "$loc/.claude-plugin/plugin.json" ]; then
            echo "$loc"
            return 0
        fi
    done

    return 1
}

# Find the source directory
DESIGN_OPS_ROOT=$(find_source_dir) || true

if [ -z "$DESIGN_OPS_ROOT" ]; then
    echo -e "${RED}Could not find DESIGN-OPS source directory${NC}"
    echo
    echo "This can happen if:"
    echo "  1. You deleted the original clone after installing"
    echo "  2. You moved the directory to a new location"
    echo "  3. You installed from a temporary directory"
    echo
    echo -e "${YELLOW}To fix, re-clone and reinstall:${NC}"
    echo
    echo "  git clone https://github.com/opensesh/DESIGN-OPS"
    echo "  bash DESIGN-OPS/.design-ops/install.sh"
    echo
    echo "This will set up the update path for future updates."
    exit 1
fi

echo -e "Source directory: ${CYAN}$DESIGN_OPS_ROOT${NC}"

# Verify it's a valid DESIGN-OPS repo
if [ ! -f "$DESIGN_OPS_ROOT/.claude-plugin/plugin.json" ]; then
    echo -e "${RED}Error: Directory doesn't appear to be DESIGN-OPS${NC}"
    exit 1
fi

cd "$DESIGN_OPS_ROOT"

# Show current version
CURRENT_COMMIT=$(git rev-parse --short HEAD)
CURRENT_DATE=$(git log -1 --format=%ci HEAD | cut -d' ' -f1)
echo -e "Current version: ${CYAN}$CURRENT_COMMIT${NC} ($CURRENT_DATE)"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    echo
    echo -e "${YELLOW}Warning: You have local changes${NC}"
    git status --short
    echo
    read -p "Stash changes and continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git stash push -m "DESIGN-OPS update stash $(date +%Y%m%d-%H%M%S)"
        echo -e "${GREEN}Changes stashed${NC}"
    else
        echo "Update cancelled. Commit or stash your changes first."
        exit 0
    fi
fi

# Fetch latest
echo
echo "Checking for updates..."
git fetch origin main --quiet 2>/dev/null || git fetch origin --quiet

# Get the default branch
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")

# Check if updates available
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse "origin/$DEFAULT_BRANCH" 2>/dev/null || git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
    echo -e "${GREEN}Already up to date!${NC}"
    echo
    echo "Your DESIGN-OPS installation is current."
    echo "No changes needed."
    exit 0
fi

# Show what's new
echo
echo -e "${YELLOW}Updates available:${NC}"
echo
git log --oneline HEAD.."origin/$DEFAULT_BRANCH" 2>/dev/null | head -10 || git log --oneline HEAD..origin/main | head -10
COMMIT_COUNT=$(git rev-list --count HEAD.."origin/$DEFAULT_BRANCH" 2>/dev/null || git rev-list --count HEAD..origin/main)
if [ "$COMMIT_COUNT" -gt 10 ]; then
    echo "  ... and $((COMMIT_COUNT - 10)) more commits"
fi
echo

# Confirm update
read -p "Apply updates? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "Update cancelled."
    exit 0
fi

# Pull changes
echo
echo "Pulling latest changes..."
if git pull origin "$DEFAULT_BRANCH" --quiet 2>/dev/null || git pull origin main --quiet; then
    NEW_COMMIT=$(git rev-parse --short HEAD)
    echo -e "${GREEN}Updated to: ${CYAN}$NEW_COMMIT${NC}"
else
    echo -e "${RED}Failed to pull changes${NC}"
    echo
    echo "Try manually:"
    echo "  cd $DESIGN_OPS_ROOT"
    echo "  git pull"
    echo "  bash .design-ops/install.sh"
    exit 1
fi

# Update saved source path (in case it moved)
mkdir -p "$DESIGN_OPS_META_DIR"
echo "$DESIGN_OPS_ROOT" > "$SOURCE_PATH_FILE"

# Reinstall plugin
echo
echo "Reinstalling plugin..."
if command -v claude &> /dev/null; then
    # Uninstall and reinstall
    claude plugin uninstall design-ops@design-ops 2>/dev/null || true
    if claude plugin install design-ops@design-ops 2>/dev/null; then
        echo -e "${GREEN}Plugin reinstalled${NC}"
    else
        echo -e "${YELLOW}Plugin reinstall returned non-zero (may still be OK)${NC}"
    fi
else
    echo -e "${YELLOW}Warning: 'claude' CLI not found${NC}"
    echo "Plugin not reinstalled automatically."
    echo "Run this in Claude Code: claude plugin install design-ops@design-ops"
fi

echo
echo -e "${GREEN}╭──────────────────────────────────────────────────────────────╮${NC}"
echo -e "${GREEN}│  Update Complete!                                            │${NC}"
echo -e "${GREEN}╰──────────────────────────────────────────────────────────────╯${NC}"
echo
echo -e "${YELLOW}Important:${NC} Start a new Claude Code session to use the updated plugin."
echo
echo "Changes in this update:"
git log --oneline "$CURRENT_COMMIT"..HEAD | head -5
echo
