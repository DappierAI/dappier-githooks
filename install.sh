#!/bin/bash

# Dappier Git Hooks Installer (Global)
# Compatible with macOS and Linux

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Dappier Git Hooks Installer v1.0    ║${NC}"
echo -e "${BLUE}║        (Global Installation)           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Determine global hooks directory based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    HOOKS_DIR="${HOME}/Library/Application Support/Git/hooks"
else
    HOOKS_DIR="${HOME}/.config/git/hooks"
fi

echo -e "${YELLOW}Installing global git hooks...${NC}"
echo ""

# Create hooks directory if it doesn't exist
mkdir -p "$HOOKS_DIR"

# Create the prepare-commit-msg hook
HOOK_FILE="$HOOKS_DIR/prepare-commit-msg"

cat > "$HOOK_FILE" << 'EOF'
#!/bin/bash

# Dappier Git Hook - Automatic Branch Name Prepend
# Prepends branch name to commit messages (e.g., feat/DP-1234: initial commit)

COMMIT_MSG_FILE=$1
COMMIT_SOURCE=$2
SHA1=$3

# Exit if this is an amend, merge, or squash
if [ "$COMMIT_SOURCE" = "merge" ] || [ "$COMMIT_SOURCE" = "squash" ]; then
    exit 0
fi

# Get the current branch name
BRANCH_NAME=$(git symbolic-ref --short HEAD 2>/dev/null)

# Exit if we couldn't get branch name
if [ -z "$BRANCH_NAME" ]; then
    exit 0
fi

# Skip if on dev, dev2, staging, or production branches
if [[ "$BRANCH_NAME" =~ ^(dev|dev2|staging|production)$ ]]; then
    exit 0
fi

# Read the current commit message
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Check if the message already starts with the branch name
if [[ "$COMMIT_MSG" == "$BRANCH_NAME:"* ]]; then
    exit 0
fi

# Check if the message already has a branch prefix pattern (to avoid double prefixing)
if [[ "$COMMIT_MSG" =~ ^[a-zA-Z0-9/_-]+:[[:space:]] ]]; then
    exit 0
fi

# Skip if this is a default git message (like merge messages)
if [[ "$COMMIT_MSG" =~ ^Merge[[:space:]] ]] || [[ "$COMMIT_MSG" =~ ^Revert[[:space:]] ]]; then
    exit 0
fi

# Prepend branch name to commit message
echo "$BRANCH_NAME: $COMMIT_MSG" > "$COMMIT_MSG_FILE"
EOF

# Make the hook executable
chmod +x "$HOOK_FILE"

# Configure git to use the global hooks directory
git config --global core.hooksPath "$HOOKS_DIR"

echo -e "${GREEN}✓ Global git hooks installed successfully!${NC}"
echo ""
echo -e "${BLUE}Hook location:${NC} $HOOK_FILE"
echo ""
echo -e "${BLUE}Git config:${NC} core.hooksPath configured globally"
echo ""
echo -e "${YELLOW}How it works:${NC}"
echo "• When you commit with: git commit -m \"initial commit\""
echo "• On branch: feat/DP-1234"
echo "• Your commit message becomes: \"feat/DP-1234: initial commit\""
echo ""
echo -e "${YELLOW}Note:${NC} Hooks are ignored on dev, dev2, staging, and production branches"
echo ""
echo -e "${GREEN}Installation complete! This applies to ALL repositories on your system. 🚀${NC}"
