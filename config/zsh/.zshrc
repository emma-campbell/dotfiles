#!/bin/zsh
#
#
# ▄▄▄ .• ▌ ▄ ·. • ▌ ▄ ·.  ▄▄▄·
# ▀▄.▀··██ ▐███▪·██ ▐███▪▐█ ▀█
# ▐▀▀▪▄▐█ ▌▐▌▐█·▐█ ▌▐▌▐█·▄█▀▀█
# ▐█▄▄▌██ ██▌▐█▌██ ██▌▐█▌▐█ ▪▐▌
#  ▀▀▀ ▀▀  █▪▀▀▀▀▀  █▪▀▀▀ ▀  ▀
#
# © 2021-2026 Emma Campbell
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

export DOTFILES="$HOME/.dotfiles"

# history is state, not config — keep it out of the repo-symlinked $ZDOTDIR
# (macOS /etc/zshrc defaults HISTFILE to $ZDOTDIR/.zsh_history)
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"

export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

DEFAULT_USER="$(whoami)"

alias reload!='source "$ZDOTDIR/.zshrc"'

# language-specific configurations (node, java, python, ...)
for f in "$ZDOTDIR"/lang/*.zsh; do
  source "$f"
done

if [[ -e ~/.dotnet.conf ]]; then
  source ~/.dotnet.conf
fi

if [[ -e ~/.docker.conf ]]; then
  source ~/.docker.conf
fi

for f in "$ZDOTDIR"/aliases/*.zsh; do
  source "$f"
done

if [[ -e ~/.localrc ]]; then
  source ~/.localrc
fi

source "$ZDOTDIR/paths.zsh"
source "$ZDOTDIR/prompt.zsh"

if [[ -e ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# "import" our utility methods
if [[ -d "$ZDOTDIR/functions" ]]; then
  local files=("${(@f)$(find -L "$ZDOTDIR/functions" -iname "*.sh")}")
  for f in "${files[@]}"; do
    source "$f"
  done
fi

if [[ -z "$CLAUDE_CODE" ]]; then
  eval "$(zoxide init zsh)"
else
  eval "$(zoxide init zsh --no-cmd)"
  alias z="__zoxide_z"
  export _ZO_DOCTOR=0
fi
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  export TERM=xterm-256color
fi

# pnpm
export PNPM_HOME="/Users/emmacampbell/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

# opencode
export PATH=/Users/emmacampbell/.opencode/bin:$PATH

# bun completions
[ -s "/Users/emmacampbell/.bun/_bun" ] && source "/Users/emmacampbell/.bun/_bun"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
eval "$(/Users/emmacampbell/.local/bin/mise activate zsh)"
