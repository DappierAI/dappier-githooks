# Dappier Git Hooks Installer for Windows (Global)
# PowerShell Script

$ErrorActionPreference = "Stop"

$BLUE = "Cyan"
$GREEN = "Green"
$YELLOW = "Yellow"
$RED = "Red"

Write-Host "╔════════════════════════════════════════╗" -ForegroundColor $BLUE
Write-Host "║   Dappier Git Hooks Installer v1.0    ║" -ForegroundColor $BLUE
Write-Host "║        (Global Installation)           ║" -ForegroundColor $BLUE
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor $BLUE
Write-Host ""

# Determine global hooks directory for Windows
$hooksDir = Join-Path $env:APPDATA "Git\hooks"

Write-Host "Installing global git hooks..." -ForegroundColor $YELLOW
Write-Host ""

# Create hooks directory if it doesn't exist
if (-not (Test-Path $hooksDir)) {
    New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
}

# Create the prepare-commit-msg hook
$hookFile = Join-Path $hooksDir "prepare-commit-msg"

# Write the hook script
$hookContent = @'
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
'@

Set-Content -Path $hookFile -Value $hookContent -NoNewline

# Configure git to use the global hooks directory
git config --global core.hooksPath $hooksDir

Write-Host "✓ Global git hooks installed successfully!" -ForegroundColor $GREEN
Write-Host ""
Write-Host "Hook location: " -NoNewline
Write-Host $hookFile -ForegroundColor $BLUE
Write-Host ""
Write-Host "Git config: " -NoNewline
Write-Host "core.hooksPath configured globally" -ForegroundColor $BLUE
Write-Host ""
Write-Host "How it works:" -ForegroundColor $YELLOW
Write-Host "• When you commit with: git commit -m `"initial commit`""
Write-Host "• On branch: feat/DP-1234"
Write-Host "• Your commit message becomes: `"feat/DP-1234: initial commit`""
Write-Host ""
Write-Host "Note: " -NoNewline -ForegroundColor $YELLOW
Write-Host "Hooks are ignored on dev, dev2, staging, and production branches"
Write-Host ""
Write-Host "Installation complete! This applies to ALL repositories on your system. 🚀" -ForegroundColor $GREEN
