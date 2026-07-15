# emma-campbell/dotfiles

<p align="center">
<img src="https://github.com/emma-campbell/dotfiles/blob/master/media/terminal.png" height="400px"/>
</p>

## Overview

Configuration is organized as [GNU stow](https://www.gnu.org/software/stow/) packages that follow the
[XDG base directory](https://specifications.freedesktop.org/basedir-spec/latest/) convention —
almost everything lands in `~/.config` instead of loose dotfiles in `~`.

```sh
.
├── README.md
├── bootstrap.sh   # full machine setup
├── link.sh        # stow the packages below into place
├── config/        # stow package → ~/.config
│   ├── zsh/       #   shell config ($ZDOTDIR): .zshrc, aliases/, lang/, functions/
│   ├── git/       #   git config + global ignore (XDG-native)
│   ├── gh/        #   GitHub CLI
│   ├── nvim/      #   Neovim (LazyVim)
│   ├── vscode/    #   VS Code
│   └── starship.toml # prompt config
├── home/          # stow package → ~ (.zshenv, .calibre.sh)
├── macos/         # stow package → ~/.config, macOS only (iterm2, karabiner)
└── os/            # OS-specific installs and preferences
```

Zsh finds its config through `~/.zshenv`, which sets `ZDOTDIR="$XDG_CONFIG_HOME/zsh"` —
so `.zshrc` and everything it sources live in `~/.config/zsh/`.

### Shell

- [zsh](https://www.zsh.org/)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)

### Prompt

- [starship](https://starship.rs/)

### Editors

- [Visual Studio Code](https://code.visualstudio.com/)
- [Neovim](https://neovim.io/)

### CLI Tools

- [zoxide](https://github.com/ajeetdsouza/zoxide) - smarter cd command
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [direnv](https://direnv.net/) - environment variable management
- [stow](https://www.gnu.org/software/stow/) - symlink manager

## Installation

> ⚠️ **WARNING**: While it's very easy to take someone's dotfiles and install them to your own machine, it's not recommended unless you understand exactly what you are doing and running.
>
> I would _highly_ recommend reading through the codebase before you decide to run the install script.

Given the warning, if you decide to continue, run the following.

### 1. Clone (or fork) the repository

```shell
git clone https://github.com/emma-campbell/dotfiles ~/.dotfiles
```

### 2. Run the Bootstrap Script

```shell
cd ~/.dotfiles
sh bootstrap.sh
```

Use `-y` to skip confirmation prompts:

```shell
sh bootstrap.sh -y
```

### Relinking after changes

Adding a new file inside an already-stowed directory (e.g. `config/zsh/aliases/`)
needs nothing — the directory symlink picks it up. After adding a whole new
package directory, re-run:

```shell
./link.sh
```

Migrating a machine from the old (pre-stow) layout? Run `./link.sh --cleanup`
once to remove the legacy `~/.*` symlinks before stowing.

### Local Overrides

Machine-specific configuration can be added to these files (not tracked by git):

- `~/.zshrc.local` - local shell configuration
- `~/.localrc` - local environment variables
- `~/.gitconfig.local` - git identity and per-machine git config

## Inspiration

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [alrra/dotfiles](https://github.com/alrra/dotfiles)
