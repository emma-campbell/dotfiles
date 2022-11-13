# dotfiles

This repository contains my (@emma-campbell) entire machine set up! I was reading the other
day about how dotfiles should be shared, and I became really inspired to create my own set up.

Originally, much of my inspiration was drawn from [holman/dotfiles](https://github.com/holman/dotfiles). I
found a deeper understanding of shell scripting from the organization of his directory. The method of installation 
wasn't really cutting it for me. I wanted something more robust, with the ability to expand to different platforms 
if need-be. The repository [alrra/dotfiles](https://github.com/alrra/dotfiles) is where I got most of the installation 
scripts, plus or minus a few things that were needed.

## Features

When creating my dotfiles, I wanted something robust, where I could run one script that would set up all of my tools 
for me. 

## Install

⚠️ **WARNING** While it's easy to take someones dotfiles and run it on your own machine, it's recommended that you _don't_ unless you completely understand exactly what you are doing.

Run the following:

```
git clone https://github.com/emma-campbell/dotfiles  ~/.dotfiles
cd ~/.dotfiles
sh ./src/os/setup.sh
```
