# Dappier Git Hooks

Automatically prepend branch names to your commit messages for better commit tracking and organization.

## 🎯 What It Does

Transforms your commit messages by automatically adding the branch name as a prefix:

**Before:**
```bash
git commit -m "initial commit"
```

**After (on branch `feat/DP-1234`):**
```
feat/DP-1234: initial commit
```

## 🚀 Quick Start

### macOS / Linux

```bash
# Navigate to your git repository
cd /path/to/your/repo

# Download and run the installer
curl -O https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/install.sh
chmod +x install.sh
./install.sh
```

Or clone and install:
```bash
git clone https://github.com/DappierAI/dappier-githooks.git
cd dappier-githooks
chmod +x install.sh
./install.sh
```

### Windows (PowerShell)

```powershell
# Navigate to your git repository
cd C:\path\to\your\repo

# Download and run the installer
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/install.ps1" -OutFile "install.ps1"
.\install.ps1
```

Or clone and install:
```powershell
git clone https://github.com/DappierAI/dappier-githooks.git
cd dappier-githooks
.\install.ps1
```

## 📋 Requirements

- Git installed on your system
- A git repository (the installer must be run from within a repo)
- **macOS/Linux:** Bash shell
- **Windows:** PowerShell and Git for Windows (with Git Bash)

## ⚙️ How It Works

The installer creates a `prepare-commit-msg` hook in your repository's `.git/hooks` directory. This hook:

1. **Extracts** the current branch name
2. **Checks** if the commit message already has a prefix
3. **Prepends** the branch name to your commit message
4. **Skips** protected branches (main, master, develop, release/*)

## 🎨 Features

- ✅ Works with all Git clients (VS Code, Fork, GitKraken, command line, etc.)
- ✅ Cross-platform (macOS, Linux, Windows)
- ✅ Prevents double-prefixing
- ✅ Skips merge and squash commits
- ✅ Ignores protected branches
- ✅ Non-intrusive installation
- ✅ Easy to uninstall

## 📝 Examples

### Feature Branch
```bash
# On branch: feat/DP-1234
git commit -m "add user authentication"
# Result: "feat/DP-1234: add user authentication"
```

### Bugfix Branch
```bash
# On branch: bugfix/DP-5678
git commit -m "fix login redirect issue"
# Result: "bugfix/DP-5678: fix login redirect issue"
```

### Protected Branches (No Prefix)
```bash
# On branch: main
git commit -m "update version"
# Result: "update version" (no prefix added)
```

## 🛡️ Protected Branches

The hook will **not** add prefixes on these branches:
- `main`
- `master`
- `develop`
- `release/*` (any release branch)

## 🔧 Manual Installation

If you prefer to install manually:

### macOS / Linux
```bash
cd /path/to/your/repo
curl -O https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/.git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg
```

### Windows
```powershell
cd C:\path\to\your\repo
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/.git/hooks/prepare-commit-msg" -OutFile ".git\hooks\prepare-commit-msg"
```

## 🗑️ Uninstalling

To remove the git hook:

### macOS / Linux
```bash
rm .git/hooks/prepare-commit-msg
```

### Windows
```powershell
Remove-Item .git\hooks\prepare-commit-msg
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

MIT License - feel free to use this in your projects!

## 🐛 Troubleshooting

### Hook not working on Windows
- Ensure Git for Windows is installed (includes Git Bash)
- Try running PowerShell as Administrator
- Verify the hook file exists: `.git/hooks/prepare-commit-msg`

### Hook not working on macOS/Linux
- Verify the hook is executable: `ls -la .git/hooks/prepare-commit-msg`
- If not, make it executable: `chmod +x .git/hooks/prepare-commit-msg`

### Commits still don't have prefix
- Check your current branch: `git branch --show-current`
- Verify you're not on a protected branch
- Check if the commit message already has a prefix

### Need help?
Open an issue on GitHub with:
- Your operating system
- Git version (`git --version`)
- The branch name you're trying to commit on
- The exact commit command you're using

## 🌟 Star This Repo

If you find this useful, please consider giving it a star! ⭐

---

Made with ❤️ by the Dappier team
