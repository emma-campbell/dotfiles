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
└── symlinks/
```

- `aliases/` contains all aliases, organized in files by type.
- `code/` contains all IDE/editor configurations, in folders by type.
- `func/` contains all helper functions
- `git/` contains all git configuration
- `lang/` contains all language specific configurations
- `os/` contains all os-specific installations and preferences
- `prompt/` contains prompt configuration
- `shell/` contains all shell configuration
- `symlinks/` contains all scripts that symlink important files to the root directory (`~/`)

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

## Installation

> ⚠️ **WARNING**: While it's very easy to take someone's dotfiles and install them to your own machine, it's not recommended unless you understand exactly what you are doing and running.
>
> I would _highly_ recommended reading through the codebase before you decide to run the install script.

Given then warning, if you decide to continue, run the following.

### 1. Clone (or fork) the directory

```shell
git clone https://github.com/emma-campbell/dotfiles  ~/.dotfiles
```

### 2. Change Directories into `~/.dotfiles`

```shell
cd ~/.dotfiles
```

### 3. Run the Bootstrap Script

```
sh bootstrap.sh
```

## Inspiration

- [holman/dotfiles](https://github.com/holman/dotfiles)
- [alrra/dotfiles](https://github.com/alrra/dotfiles)
