# dotfiles

This repository contains my (@spookyexistence) entire machine set up! I was reading the other
day about how dotfiles should be shared, and I became really inspired to create my own set up.

Originally, much of my inspiration was drawn from [holman/dotfiles](https://github.com/holman/dotfiles). I
found a deeper understanding of shell scripting from the organization of his directory. The method of installation wasn't really cutting it for me. I wanted something more robust, with the ability to expand to different platforms if need-be. The repository [alrra/dotfiles](https://github.com/alrra/dotfiles) is where I got most of the installation scripts, plus or minus a few things that were needed.

## Features

When creating my dotfiles, I wanted something robust, where I could run 1 script that would set up all of my tools for me. 

As I got further into creating my ideal setup, I realized there were some things I would like to include that weren't built into to ohmyzsh, like
   * [typewritten](https://github.com/reobin/typewritten)
   * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting.git)
   * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

Before, I was using Spacemacs and had a seperate repository setting that up, but now I have changed to Vim and TMUX, which are also setup through this script. For vim plugins, I use [Vundle](https://github.com/Vundle/Vundle.vim) as a package-manager.

## Install

Run the following:
```
git clone https://github.com/spookyexistence/dotfiles  ~/.dotfiles
cd ~/.dotfiles
sh ./src/os/setup.sh
```
