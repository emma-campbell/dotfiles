#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

download_spacecamp() {

    local SPACECAMP_VIM_FILE="https://raw.githubusercontent.com/jaredgorski/SpaceCamp/master/colors/spacecamp.vim"

    execute \
        "curl -l $SPACECAMP_VIM_FILE -o $HOME/.vim/colors/spacecamp.vim" \
        "Install spacecamp" \
    || return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    declare -r VIM_VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
    declare -r VUNDLE_REPO_URL="https://github.com/VundleVim/Vundle.vim"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install plugins.
    if [ ! -d $VIM_VUNDLE_DIR ];
    then
        execute \
            "git clone --quiet $VUNDLE_REPO_URL $VIM_VUNDLE_DIR" \
            "vundle (install)" \
        || return 1
    else

        ask_for_confirmation "$VIM_VUNDLE_DIR already exists. Would you like to overwrite it?"

        if answer_is_yes;
        then
            rm -rf $VIM_VUNDLE_DIR

            execute \
               "git clone $VUNDLE_REPO_URL $VIM_VUNDLE_DIR" \
               "vundle (install)" \
            || return 1

        fi
    fi


    download_spacecamp
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Vim\n\n"

    "./$(get_os)/vim.sh"

    install_plugins

}

main
