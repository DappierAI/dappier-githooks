# Quick Install Guide

## 🚀 Easiest Installation (Copy & Paste)

### macOS / Linux
```bash
# 1. Go to your git repository
cd /path/to/your/repo

# 2. Run this one command
bash <(curl -s https://raw.githubusercontent.com/DappierAI/dappier-githooks/main/install.sh)
```

### Windows (PowerShell)
```powershell
# 1. Go to your git repository
cd C:\path\to\your\repo

# 2. Run this one command
iex (iwr -Uri "https://raw.githubusercontent.com/DappierAI/dappier-githooks/main/install.ps1").Content
```

## ✅ That's it!

Now when you commit:
```bash
git commit -m "initial commit"
```

On branch `feat/DP-1234`, it becomes:
```
feat/DP-1234: initial commit
```

## 📚 Need more info?

Check out the [full README](README.md) for:
- Alternative installation methods
- How it works
- Configuration options
- Troubleshooting

---

**Note:** The one-liner installation requires an internet connection to download the script directly from GitHub.
