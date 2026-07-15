#!/bin/bash

eval "$(starship init zsh)"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -e ~/.prompt.local ]]; then
  source ~/.prompt.local
fi
