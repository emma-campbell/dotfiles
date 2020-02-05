#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

download_spacecamp() {
    local SPACECAMP_VIM_FILE="https://raw.githubusercontent.com/jaredgorski/SpaceCamp/master/colors/spacecamp.vim"

    execute \
        "curl -L $SPACECAMP_VIM_FILE $HOME/.vim/colors/spacecamp.vim" \
        "Install spacecamp" \
    || return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    declare -r VIM_VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
    declare -r VUNDLE_REPO_URL="https://github.com/VundleVim/Vundle.vim"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install plugins.

    execute \
        "rm -rf $VIM_VUNDLE_DIR && git clone --quiet $VUNDLE_REPO_URL $VIM_VUNDLE_DIR" \
        "Install plugins" \
    || return 1

    download_spacecamp

    vim :PluginsInstall

}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Vim\n\n"

    "./$(get_os)/vim.sh"
    install_plugins

}

main
