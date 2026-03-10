# emma-campbell/dotfiles

<p align="center">
<img src="https://github.com/emma-campbell/dotfiles/blob/master/media/terminal.png" height="400px"/>
</p>

## Overview

Here is a brief overview of how the project is organized.

```sh
.
├── README.md
├── aliases/
├── code/
├── func/
├── git/
├── lang/
├── os/
├── prompt/
├── shell/
├── symlinks/
└── tools/
```

- `aliases/` contains all aliases, organized in files by type
- `code/` contains all IDE/editor configurations, in folders by type
- `func/` contains all helper functions (sourced into shell)
- `git/` contains all git configuration
- `lang/` contains all language specific configurations (node, java, python, rust, etc.)
- `os/` contains all OS-specific installations and preferences
- `prompt/` contains prompt configuration (oh-my-posh theme)
- `shell/` contains all shell configuration (zshrc, paths, etc.)
- `symlinks/` contains all scripts that symlink important files to `~/`
- `tools/` contains configuration for additional tools

### Shell

- [zsh](https://www.zsh.org/)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)

### Prompt

- [oh-my-posh](https://ohmyposh.dev/)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)

### Editors

- [Visual Studio Code](https://code.visualstudio.com/)
- [Neovim](https://neovim.io/)

### CLI Tools

- [zoxide](https://github.com/ajeetdsouza/zoxide) - smarter cd command
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [direnv](https://direnv.net/) - environment variable management

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

### Local Overrides

Machine-specific configuration can be added to these files (not tracked by git):

- `~/.zshrc.local` - local shell configuration
- `~/.localrc` - local environment variables

## Inspiration

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [alrra/dotfiles](https://github.com/alrra/dotfiles)
