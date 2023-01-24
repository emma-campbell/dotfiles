#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

export ZSH_CUSTOM_PLUGINS="$ZSH/custom/plugins"
export ZSH_CUSTOM_THEMES="$ZSH/custom/themes"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_zsh_syntax_highlighting() {
    brew_install "ZSH Syntax Highlighting" "zsh-syntax-highlighting"
    print_result $? "zsh-syntax-highlighting"
}


install_zsh_autosuggestions() {
    brew_install "ZSH Autosuggestions" "zsh-autosuggestions"
    print_result $? "zsh-autosuggestions"
}

install_plugins() {
    install_zsh_syntax_highlighting && \
        install_zsh_autosuggestions
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_oh_my_posh() {
    brew_tap jandedobbeleer/oh-my-posh && brew_install "Oh My Posh" "oh-my-posh"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n   shell_prompt\n\n"
    install_oh_my_posh && install_plugins
}

main
