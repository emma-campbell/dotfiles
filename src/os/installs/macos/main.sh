#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh
./prompt.sh
./lazydocker.sh
./git.sh
./chrome.sh
./vscode.sh
./../nvm.sh
./../nvim.sh
./yarn.sh
