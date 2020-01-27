# dotfiles

This repository contains my (@emma-campbell) entire machine set up! I was reading the other
day about how dotfiles should be shared, and I became really inspired to create my own set up.

Much of my inspiration was drawn from [holman/dotfiles](https://github.com/holman/dotfiles). I
found a deeper understanding of shell scripting from the organization of his directory. However, I wanted to modify the it to be based on top of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh.git) to have access to the sheer amount of plugins in the repo.

## Custom Dot-Modules

The install script to `oh-my-zsh` is found in the directory sharing its name -- the install/bootstrap script from @holman makes adding custom software easy -- `install.sh` in every directory will be run.

On top of that, I have also included
   * [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt.git)
   * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)
   * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

## Install

Run the following:
```
git clone https://github.com/emma-campbell/dotfiles  ~/.dotfiles
cd ~/.dotfiles
scripts/bootstrap
```
