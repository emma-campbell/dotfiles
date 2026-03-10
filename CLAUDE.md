# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that manages shell configuration, editor settings, and system preferences through symlinks.

## Key Commands

```bash
# Full installation (from scratch)
sh bootstrap.sh

# Skip confirmation prompts
sh bootstrap.sh -y

# Re-run symlink scripts only (after making changes to dotfiles)
for f in symlinks/*.sh; do "./$f"; done

# Restart shell after changes
source ~/.zshrc
```

## Architecture

### Bootstrap Flow
1. `bootstrap.sh` → Sources `utils.sh` for helper functions
2. Runs `symlinks/local.sh` (creates `~/.local.zshrc`)
3. Runs `ssh.sh` (SSH key setup)
4. Runs `os/main.sh` → Detects OS and runs `os/macos/configure.sh`
5. Runs all `symlinks/*.sh` scripts to create symlinks
6. Sources `~/.zshrc`

### macOS Configuration (`os/macos/configure.sh`)
1. Installs/updates Homebrew
2. Runs install scripts in `os/macos/install/`
3. Applies system preferences from `os/macos/prefs/`
4. Creates config symlinks via `link.sh`

### Shell Loading Order (`shell/zshrc`)
1. Language configs: `~/.node`, `~/.java`, `~/.python`, `~/.rust`, `~/.ruby`, `~/.terraform`, `~/.dotnet.conf`, `~/.docker.conf` (if exist)
2. Aliases: `~/.aliases.*` files
3. Local overrides: `~/.localrc`
4. Paths: `~/.paths`
5. Prompt: `~/.prompt`
6. Local zshrc: `~/.zshrc.local` (machine-specific)
7. Functions: All `*.sh` files in `~/.func/`
8. Tools: zoxide, direnv, fzf, nvm

### Symlink Convention
Each `symlinks/*.sh` script creates symlinks from dotfiles in this repo to `~/`:
- `shell/zshrc` → `~/.zshrc`
- `aliases/aliases.*` → `~/.aliases.*`
- `git/gitconfig` → `~/.gitconfig`
- `lang/*` → `~/.node`, `~/.java`, etc.
- `func/` → `~/.func/`

### Utility Functions (`utils.sh`)
Provides helpers used throughout: `execute`, `print_result`, `print_success`, `print_error`, `ask_for_confirmation`, `answer_is_yes`, `cmd_exists`, `get_os`
