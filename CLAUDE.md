# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository organized as GNU stow packages following the XDG base directory convention. Nearly all configuration is symlinked into `~/.config`; the home directory only gets `~/.zshenv` (which sets `ZDOTDIR`) and `~/.calibre.sh`.

## Key Commands

```bash
# Full installation (from scratch)
sh bootstrap.sh

# Skip confirmation prompts
sh bootstrap.sh -y

# Re-stow packages (only needed after adding a NEW package directory —
# files added inside existing dirs are picked up by the dir symlink)
./link.sh

# One-time migration from the old pre-stow layout
./link.sh --cleanup

# Restart shell after changes
exec zsh   # or: reload!
```

## Architecture

### Stow Packages
- `config/` → stowed into `~/.config` (tree-folded: each subdir becomes one symlink, e.g. `~/.config/zsh → ~/.dotfiles/config/zsh`)
  - `zsh/` — `$ZDOTDIR`: `.zshrc`, `paths.zsh`, `prompt.zsh`, `aliases/*.zsh`, `lang/*.zsh`, `functions/**/*.sh`
  - `git/` — `config` + `ignore` (XDG-native; no `~/.gitconfig`)
  - `gh/`, `nvim/`, `vscode/`, `starship.toml`, `.curlrc`
- `home/` → stowed into `~`: `.zshenv` (sets `XDG_CONFIG_HOME` + `ZDOTDIR`), `.calibre.sh`
- `macos/` → stowed into `~/.config`, macOS only: `iterm2/`, `karabiner/`

### Bootstrap Flow
1. `bootstrap.sh` → Sources `utils.sh` for helper functions
2. Runs `ssh.sh` (SSH key setup)
3. Runs `os/main.sh` → Detects OS and runs `os/macos/configure.sh` (Homebrew, installs in `os/macos/install/`, prefs in `os/macos/prefs/`)
4. Runs `./link.sh` → installs stow if missing, stows the packages, prompts for `~/.gitconfig.local` if absent
5. `exec zsh`

### Shell Loading Order (`config/zsh/.zshrc`)
1. Language configs: `$ZDOTDIR/lang/*.zsh` (+ `~/.dotnet.conf`, `~/.docker.conf` if exist)
2. Aliases: `$ZDOTDIR/aliases/*.zsh`
3. Local overrides: `~/.localrc`
4. Paths: `$ZDOTDIR/paths.zsh`
5. Prompt: `$ZDOTDIR/prompt.zsh` (starship, config in `config/starship.toml`)
6. Local zshrc: `~/.zshrc.local` (machine-specific)
7. Functions: all `*.sh` files under `$ZDOTDIR/functions/`
8. Tools: zoxide, direnv, fzf

Machine-local overrides stay in `~` on purpose (`~/.zshrc.local`, `~/.localrc`, `~/.gitconfig.local`, `~/.*.local`) — they're untracked, and placing them inside the repo-symlinked `~/.config/zsh` would dirty the working tree.

### Linking Rules
- Never hand-`ln` into `~/.config` — stow owns those links. Use `./link.sh`.
- `link.sh --cleanup` removes only symlinks that resolve into `~/.dotfiles`.

### Utility Functions (`utils.sh`)
Provides helpers used throughout: `execute`, `print_result`, `print_success`, `print_error`, `ask_for_confirmation`, `answer_is_yes`, `cmd_exists`, `get_os`
