export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# make cargo available to non-interactive shells too (rustup convention)
[ -e "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
