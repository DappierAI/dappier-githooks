# Dappier Git Hooks Installer for Windows
# PowerShell Script

$ErrorActionPreference = "Stop"

$BLUE = "Cyan"
$GREEN = "Green"
$YELLOW = "Yellow"
$RED = "Red"

Write-Host "╔════════════════════════════════════════╗" -ForegroundColor $BLUE
Write-Host "║   Dappier Git Hooks Installer v1.0    ║" -ForegroundColor $BLUE
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor $BLUE
Write-Host ""

# Check if we're in a git repository
try {
    $gitDir = git rev-parse --git-dir 2>$null
    if (-not $gitDir) {
        throw "Not a git repository"
    }
} catch {
    Write-Host "Error: Not a git repository!" -ForegroundColor $RED
    Write-Host "Please run this script from the root of your git repository."
    exit 1
}

$hooksDir = Join-Path $gitDir "hooks"

Write-Host "Installing git hooks..." -ForegroundColor $YELLOW
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

# Skip if on main, master, develop, or release branches
if [[ "$BRANCH_NAME" =~ ^(main|master|develop|release/.*)$ ]]; then
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

# Git on Windows uses Git Bash, so the hook should work as-is
# But we need to ensure it's executable (Git for Windows handles this)

Write-Host "✓ Git hooks installed successfully!" -ForegroundColor $GREEN
Write-Host ""
Write-Host "Hook location: " -NoNewline
Write-Host $hookFile -ForegroundColor $BLUE
Write-Host ""
Write-Host "How it works:" -ForegroundColor $YELLOW
Write-Host "• When you commit with: git commit -m `"initial commit`""
Write-Host "• On branch: feat/DP-1234"
Write-Host "• Your commit message becomes: `"feat/DP-1234: initial commit`""
Write-Host ""
Write-Host "Note: " -NoNewline -ForegroundColor $YELLOW
Write-Host "Hooks are ignored on main, master, develop, and release branches"
Write-Host ""
Write-Host "Installation complete! Happy committing! 🚀" -ForegroundColor $GREEN
