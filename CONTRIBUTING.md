# Contributing to Dappier Git Hooks

Thank you for your interest in contributing! We welcome contributions from the community.

## 🤝 How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- Your operating system and version
- Git version (`git --version`)
- Steps to reproduce the issue
- Expected vs actual behavior
- Any error messages

### Suggesting Enhancements

We'd love to hear your ideas! Open an issue with:
- A clear description of the enhancement
- Why it would be useful
- Examples of how it would work

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test on both Windows and macOS/Linux if possible
5. Commit your changes (`git commit -m 'feat: add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📝 Commit Message Guidelines

We follow conventional commits format:
- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

## 🧪 Testing

Before submitting a PR, please test your changes:

### macOS/Linux
```bash
# Test the installer
./install.sh

# Test a commit
git checkout -b test/DP-TEST
git commit --allow-empty -m "test commit"
git log -1 --pretty=%B
```

### Windows
```powershell
# Test the installer
.\install.ps1

# Test a commit
git checkout -b test/DP-TEST
git commit --allow-empty -m "test commit"
git log -1 --pretty=%B
```

## 📜 Code Style

- Use clear, descriptive variable names
- Add comments for complex logic
- Keep functions small and focused
- Follow shell scripting best practices

## ❓ Questions?

Feel free to open an issue for any questions or reach out to the maintainers.

Thank you for contributing! 🎉
