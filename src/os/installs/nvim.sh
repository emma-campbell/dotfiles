#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

download_spacecamp() {

    local SPACECAMP_VIM_FILE="https://raw.githubusercontent.com/jaredgorski/SpaceCamp/master/colors/spacecamp.vim"

    execute \
        "curl -l $SPACECAMP_VIM_FILE -o $HOME/.dotfiles/src/config/nvim/colors" \
        "Install spacecamp" \
    || return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    declare -r VIM_PLUG_DIR="$HOME/.dotfiles/src/config/nvim/autoload"
    declare -r VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install plugins.
    if [ ! -d $VIM_PLUG_DIR ];
    then
        execute \
            "curl -fLo $VIM_PLUG_DIR $VIM_PLUG_URL" \
            "vim-plug (install)" \
        || return 1
    else

        ask_for_confirmation "$VIM_PLUG_DIR already exists. Would you like to overwrite it?"

        if answer_is_yes;
        then
            rm -rf $VIM_PLUG_DIR

        	execute \
            		"curl -fLo $VIM_PLUG_DIR/plug.vim $VIM_PLUG_URL" \
            		"vim-plug (install)" \
        	|| return 1

        fi
    fi


    download_spacecamp
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Vim\n\n"

    "./$(get_os)/nvim.sh"

    install_plugins

}

main
