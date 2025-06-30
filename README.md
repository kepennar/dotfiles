# Personal Dotfiles with Chezmoi

This repository contains my personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), a dotfile manager that handles templating, secrets, and cross-platform configurations.

## Features

- **Multi-OS support (WIP)**: Efforts are ongoing to expand compatibility across multiple operating systems (arch, ubuntu)
- **Automated package installation**: Installs essential development tools and applications
- **Shell configuration**: Zsh with oh-my-zsh setup
- **Development environment**: VS Code, Node.js, Python, Docker configuration
- **Font management**: Cascadia Code Nerd Font installation
- **Security**: Encrypted sensitive files with proper ignore patterns

## Quick Start

### Prerequisites

Install chezmoi:
```bash
# On Arch/Manjaro
sudo pacman -S chezmoi

# On Ubuntu/Debian
snap install chezmoi --classic
```

### Installation

1. Initialize chezmoi with this repository:
```bash
chezmoi init git@github.com:kepennar/dotfiles.git
```

2. Preview changes:
```bash
chezmoi diff
```

3. Apply the configuration:
```bash
chezmoi apply
```

4. Install packages (run once):
```bash
chezmoi apply --include=scripts
```

## Configuration Structure

### Core Files

- `.bashrc`, `.zshrc` - Shell configurations with custom aliases and functions
- `.gitconfig.tmpl` - Git configuration with templated user info
- `.aliases`, `.functions` - Modular shell customizations
- `.autoloader` - Dynamic loading of shell configurations

### Application Configs

- `dot_config/Code/User/settings.json` - VS Code settings
- `dot_config/terminator/config` - Terminator terminal configuration
- `encrypted_dot_npmrc.tmpl` - Encrypted npm registry configuration

### Scripts

- `run_once_install-packages.sh.tmpl` - One-time package installation
- `run_after_install-fonts.sh.tmpl` - Font installation script

### Chezmoi Configuration

- `.chezmoidata.yaml` - Template variables and OS detection
- `.chezmoiignore` - Files to exclude from management

## Customization

### Personal Information

Update `.chezmoidata.yaml` with your details:
```yaml
personal:
  name: "Your Name"
  email: "your.email@example.com"
  github_username: "yourusername"
```

### Package Selection

Modify `run_once_install-packages.sh.tmpl` to add/remove packages based on your needs.

### Shell Customization

- Add custom aliases in `executable_dot_aliases`
- Add custom functions in `executable_dot_functions`
- Extend shell configuration in `.bashrc` or `.zshrc`

## Security Features

- Encrypted storage for sensitive configurations (`.npmrc`)
- Comprehensive `.chezmoiignore` to prevent accidental exposure of secrets
- Git hooks and sensitive file patterns excluded automatically

## OS Support (WIP)

Currently configured for:
- **Arch Linux / Manjaro**: Full automated setup with pacman and yay
- **Ubuntu / Debian**: Automated setup with apt and manual tool installation
- **Other distributions**: Manual installation guidance provided

## Commands

```bash
# Apply changes
chezmoi apply

# Edit a file
chezmoi edit ~/.bashrc

# Add a new file
chezmoi add ~/.newconfig

# Update from source
chezmoi update

# Check for differences
chezmoi diff

# Run scripts
chezmoi apply --include=scripts
```
