#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh
./zsh.sh

./git.sh
./chrome.sh
./gimp.sh
./vscode.sh
./../nvm.sh
./../nvim.sh
./yarn.sh
