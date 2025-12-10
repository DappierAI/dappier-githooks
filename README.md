# Dappier Git Hooks

Automatically prepend branch names to your commit messages for better commit tracking and organization.

**🌍 Global Installation** - Install once and use across all your Git repositories!

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

### ⚡ Easiest Installation (Copy & Paste)

#### macOS / Linux
```bash
bash <(curl -s https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/install.sh)
```

#### Windows (PowerShell)
```powershell
iex (iwr -Uri "https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/install.ps1").Content
```

### Traditional Installation

#### macOS / Linux

```bash
# Download and run the installer (from any directory)
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

#### Windows (PowerShell)

```powershell
# Download and run the installer (from any directory)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/install.ps1" -OutFile "install.ps1"
.\install.ps1
```

Or clone and install:
```powershell
git clone https://github.com/DappierAI/dappier-githooks.git
cd dappier-githooks
.\install.ps1
```

### ✅ That's it!

Now when you commit:
```bash
git commit -m "initial commit"
```

On branch `feat/DP-1234`, it becomes:
```
feat/DP-1234: initial commit
```

## 📋 Requirements

- Git installed on your system
- **macOS/Linux:** Bash shell
- **Windows:** PowerShell and Git for Windows (with Git Bash)

## ⚙️ How It Works

The installer creates a `prepare-commit-msg` hook in your system's global git hooks directory and configures Git to use it for all repositories. This hook:

1. **Extracts** the current branch name
2. **Checks** if the commit message already has a prefix
3. **Prepends** the branch name to your commit message
4. **Skips** protected branches (dev, dev2, staging, production)

**Hook locations:**
- **macOS:** `~/Library/Application Support/Git/hooks/prepare-commit-msg`
- **Linux:** `~/.config/git/hooks/prepare-commit-msg`
- **Windows:** `%APPDATA%\Git\hooks\prepare-commit-msg`

## 🎨 Features

- ✅ **Global installation** - applies to all repositories on your system
- ✅ Works with all Git clients (VS Code, Fork, GitKraken, command line, etc.)
- ✅ Cross-platform (macOS, Linux, Windows)
- ✅ Prevents double-prefixing
- ✅ Skips merge and squash commits
- ✅ Ignores protected branches
- ✅ No per-repository setup needed
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
- `dev`
- `dev2`
- `staging`
- `production`

## 🔧 Manual Installation

If you prefer to install manually:

### macOS
```bash
mkdir -p "$HOME/Library/Application Support/Git/hooks"
curl -O "$HOME/Library/Application Support/Git/hooks/prepare-commit-msg" https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/prepare-commit-msg
chmod +x "$HOME/Library/Application Support/Git/hooks/prepare-commit-msg"
git config --global core.hooksPath "$HOME/Library/Application Support/Git/hooks"
```

### Linux
```bash
mkdir -p ~/.config/git/hooks
curl -O ~/.config/git/hooks/prepare-commit-msg https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/prepare-commit-msg
chmod +x ~/.config/git/hooks/prepare-commit-msg
git config --global core.hooksPath ~/.config/git/hooks
```

### Windows
```powershell
$hooksDir = "$env:APPDATA\Git\hooks"
New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DappierAI/dappier-githooks/staging/prepare-commit-msg" -OutFile "$hooksDir\prepare-commit-msg"
git config --global core.hooksPath $hooksDir
```

## 🗑️ Uninstalling

To remove the global git hook:

### macOS
```bash
rm "$HOME/Library/Application Support/Git/hooks/prepare-commit-msg"
```

### Linux
```bash
rm ~/.config/git/hooks/prepare-commit-msg
```

### Windows
```powershell
Remove-Item "$env:APPDATA\Git\hooks\prepare-commit-msg"
```

To disable the hooks globally (without removing them):
```bash
git config --global --unset core.hooksPath
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

MIT License - feel free to use this in your projects!

## 🐛 Troubleshooting

### Hook not working on Windows
- Ensure Git for Windows is installed (includes Git Bash)
- Try running PowerShell as Administrator
- Verify the hook file exists: `%APPDATA%\Git\hooks\prepare-commit-msg`
- Check git config: `git config --global core.hooksPath`

### Hook not working on macOS/Linux
- Verify the hook is executable: `ls -la ~/Library/Application\ Support/Git/hooks/prepare-commit-msg` (macOS) or `ls -la ~/.config/git/hooks/prepare-commit-msg` (Linux)
- Check git config: `git config --global core.hooksPath`
- If hook is not executable, make it executable: `chmod +x` on the hook file

### Commits still don't have prefix
- Check your current branch: `git branch --show-current`
- Verify you're not on a protected branch (dev, dev2, staging, production)
- Check if the commit message already has a prefix
- Verify git config is set: `git config --global core.hooksPath` should return your hooks directory

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
