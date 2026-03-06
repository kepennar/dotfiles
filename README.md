# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

Declarative, reproducible setup: **Ghostty** + **Starship** + **mise** + **direnv** + **zsh**.

## Philosophy

- **Declarative** — all config lives in this repo, applied via `chezmoi apply`
- **Minimal** — no frameworks, just native zsh modules
- **Feature toggles** — disable entire subsystems via `.chezmoidata.yaml`
- **Secrets model** — private files via `private_` prefix, encrypted files via `encrypted_`, keys never in the repo

## Repository Structure

```
.chezmoi.toml.tmpl                       # Chezmoi config (age encryption, prompted data)
.chezmoidata.yaml                        # Template variables & feature toggles
.chezmoiignore                           # Files excluded from management
.gitignore                               # Safety net (age keys, decrypted secrets)

run_onchange_bootstrap-system.sh.tmpl    # Base packages, CLI tools, fonts, zsh
run_onchange_bootstrap-dev.sh.tmpl       # mise, direnv, lazygit, docker
run_onchange_bootstrap-desktop.sh.tmpl   # GUI apps (ghostty, vscode, starship)

dot_zshrc.tmpl                           # Minimal zshrc (sources modules)
dot_config/
  zsh/
    path.zsh.tmpl                        # PATH consolidation
    exports.zsh.tmpl                     # EDITOR, SSH_AUTH_SOCK
    completion.zsh                       # compinit + plugins
    aliases.zsh                          # Git, eza, modern CLI aliases
    functions.zsh.tmpl                   # Shell functions (mkd, fgit, etc.)
    integrations.zsh.tmpl                # mise, direnv, starship activation
  git/config.tmpl                        # Git configuration (XDG)
  ghostty/config.tmpl                    # Ghostty terminal
  starship.toml                          # Starship prompt
  mise/config.toml.tmpl                  # mise runtimes (node, python, bun)
  direnv/direnvrc                        # direnv + mise integration
  Code/User/settings.json.tmpl           # VS Code settings (templated fonts)

private_dot_ssh/
  config.tmpl                            # SSH config (permissions 0600)
  dot_gitkeep                            # Ensures ~/.ssh/ directory exists

dot_local/bin/
  executable_dotfiles-doctor.sh.tmpl     # Health check script
  executable_dotfiles-backup.sh.tmpl     # Backup secrets & system state
```

## Data Model

Static variables are defined in `.chezmoidata.yaml`. Personal data (`email`, `github_username`) is prompted during `chezmoi init` and stored in `.chezmoi.toml.tmpl`.

| Section | Key | Default | Source | Description |
|---------|-----|---------|--------|-------------|
| `personal` | `name` | `kepennar` | data | Username |
| `personal` | `email` | *(prompted)* | config | Git email (prompted on init) |
| `personal` | `github_username` | *(prompted)* | config | GitHub username (prompted on init) |
| `machine` | `role` | `desktop` | `desktop` or `server` |
| `machine` | `desktop` | `gnome` | `gnome`, `kde`, `sway`, `none` |
| `features` | `gui` | `true` | Enable GUI app management |
| `features` | `docker` | `true` | Docker + docker-compose |
| `features` | `kubernetes` | `false` | Kubernetes tools |
| `features` | `cloud_sdk` | `false` | Google Cloud SDK |
| `features` | `install_fonts` | `true` | Cascadia Code Nerd Font |
| `features` | `flatpak_apps` | `false` | Flatpak applications |
| `features` | `work_profile` | `false` | Work-specific config (SSH includes) |
| `features` | `install_desktop_apps` | `true` | Desktop app bootstrap |
| `features` | `install_dev_tools` | `true` | Dev tools bootstrap |
| `development` | `editor` | `code` | Default editor |
| `development` | `shell` | `zsh` | Default shell |
| `development` | `terminal` | `ghostty` | Terminal emulator |
| `fonts` | `terminal` | `CaskaydiaCove Nerd Font` | Terminal font |
| `fonts` | `editor` | `CaskaydiaCove Nerd Font` | Editor font |
| `paths` | `workspace` | `~/workspace` | Workspace directory |
| `tools` | `node_version` | `lts` | Node.js version for mise |
| `tools` | `python_version` | `3.11` | Python version for mise |

## Bootstrap Workflow

### Prerequisites

Generate an age encryption key (required for encrypted secrets):

```bash
mkdir -p ~/.config/sops/age
chezmoi age-keygen --output ~/.config/sops/age/chezmoi.txt
```

### Fresh install

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply kepennar
```

You will be prompted for your email and GitHub username on first init.

### Existing machine

```bash
chezmoi init git@github.com:kepennar/dotfiles.git
chezmoi diff    # review changes
chezmoi apply   # apply
```

### Script execution order

1. `bootstrap-system` — base packages, CLI tools, fonts, sets zsh as default shell
2. `bootstrap-dev` — mise, direnv, lazygit, gh, just, docker
3. `bootstrap-desktop` — ghostty, VS Code, starship, chrome, discord

Scripts run on change (hash of `.chezmoidata.yaml`). To skip a phase, set its feature flag to `false`:

- `install_dev_tools: false` — skips `bootstrap-dev`
- `gui: false` or `install_desktop_apps: false` — skips `bootstrap-desktop`

## Secrets Model

Encryption uses [age](https://age-encryption.org/) via chezmoi's built-in support, configured in `.chezmoi.toml.tmpl`.

| Prefix | Permissions | Encryption | Use case |
|--------|-------------|------------|----------|
| `private_` | 0600 | None | SSH config, sensitive config files |
| `encrypted_` | 0600 | age | Tokens, API keys, npmrc |
| *(none)* | 0644 | None | Regular config files |

**Rules:**
- Age identity key lives at `~/.config/sops/age/chezmoi.txt` — **never** committed (`.gitignore` safety net)
- Private SSH keys (`id_ed25519`, `id_rsa`) are **never** stored in the repo — they are listed in `.chezmoiignore`
- Use `dotfiles-backup.sh` to create encrypted backups of keys
- SSH config is managed via `private_dot_ssh/config.tmpl`

## Managed Applications

| Application | Config path | Managed | Templated |
|-------------|------------|---------|-----------|
| zsh | `~/.zshrc`, `~/.config/zsh/` | Yes | Yes |
| git | `~/.config/git/config` | Yes | Yes |
| Ghostty | `~/.config/ghostty/config` | Yes | Yes |
| Starship | `~/.config/starship.toml` | Yes | No |
| mise | `~/.config/mise/config.toml` | Yes | Yes |
| direnv | `~/.config/direnv/direnvrc` | Yes | No |
| VS Code | `~/.config/Code/User/settings.json` | Yes | Yes (fonts) |
| SSH | `~/.ssh/config` | Yes | Yes |
| nvim | — | No | — |
| tmux | — | No | — |

## Safety Tools

### dotfiles-doctor

Health check for the dotfiles setup. Installed at `~/.local/bin/dotfiles-doctor.sh`.

```bash
dotfiles-doctor.sh
```

Checks: zsh default shell, starship, ghostty, mise, direnv, git config, ssh-agent, docker (if enabled).

Output: `[OK]`/`[FAIL]`/`[WARN]` per check, exit code 1 if any failures.

### dotfiles-backup

Backup secrets and system state. Installed at `~/.local/bin/dotfiles-backup.sh`.

```bash
dotfiles-backup.sh
```

Creates a `.tar.gz` archive in `~/backups/` containing:
- SSH keys (`~/.ssh/`)
- GPG keys (armor export)
- Workspace repos list
- Installed packages (pacman/apt)
- VS Code extensions
- Chezmoi status and data

## Recovery and Rebuild

### Full rebuild on a new machine

```bash
# 1. Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply kepennar

# 2. Restore backup (from USB/cloud)
tar xzf dotfiles-backup-*.tar.gz
cp -r dotfiles-backup-*/ssh/* ~/.ssh/
chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_*

# 3. Restore GPG keys
gpg --import dotfiles-backup-*/gpg/secret-keys.asc
gpg --import-ownertrust dotfiles-backup-*/gpg/ownertrust.txt

# 4. Reinstall VS Code extensions
cat dotfiles-backup-*/vscode-extensions.txt | xargs -L 1 code --install-extension

# 5. Verify
dotfiles-doctor.sh
```

## Maintenance

### Add a new config file

```bash
chezmoi add ~/.config/app/config.toml
# Edit the source: chezmoi edit ~/.config/app/config.toml
# Apply: chezmoi apply
```

### Add a templated config

```bash
chezmoi add --template ~/.config/app/config.toml
# Edit with template syntax in the source directory
```

### Manage a secret

```bash
# Option 1: private_ prefix (no encryption, 0600 perms)
chezmoi add --private ~/.config/app/secret.conf

# Option 2: encrypted_ prefix (age encryption)
chezmoi add --encrypt ~/.config/app/token.txt
```

### Update packages

Edit `.chezmoidata.yaml` to change versions or toggle features, then:

```bash
chezmoi apply
```

The `run_onchange_` scripts will re-execute because the hash of `.chezmoidata.yaml` changes.

## OS Support

Auto-detected via `chezmoi.osRelease.id`:

| OS | Package manager | AUR | Notes |
|----|----------------|-----|-------|
| **Arch / Manjaro** | pacman | yay | Primary target |
| **Ubuntu** | apt | — | Manual installs for some tools |

## Troubleshooting

**Starship prompt not showing:** Ensure `starship` is installed (`bootstrap-desktop` handles this) and open a new terminal.

**Node/Python not found:** Run `mise install` to install runtimes. Check `~/.config/mise/config.toml`.

**Old oh-my-zsh errors:** Remove `~/.oh-my-zsh` directory — it is no longer used.

**Fonts not rendering:** Run `fc-cache -fv` and restart your terminal.

**Bootstrap script not re-running:** Scripts trigger on change to `.chezmoidata.yaml`. Edit the data file or run `chezmoi apply --force`.

**SSH permissions wrong:** chezmoi uses the `private_` prefix to set 0600. If permissions are wrong, run `chezmoi apply` again or `chmod 600 ~/.ssh/config`.

**VS Code terminal font wrong:** Check that `fonts.terminal` in `.chezmoidata.yaml` matches an installed font. Run `fc-list | grep -i caskaydia` to verify.

**dotfiles-doctor fails:** Run the doctor script to identify which components are missing, then run the appropriate bootstrap script or install manually.
