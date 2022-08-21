#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

export ZSH_CUSTOM_PLUGINS="$ZSH/custom/plugins"
export ZSH_CUSTOM_THEMES="$ZSH/custom/themes"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_zsh_syntax_highlighting() {

    local ZSH_SYNTAX_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"

    if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ];
    then
        execute \
            "git clone $ZSH_SYNTAX_HIGHLIGHTING "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"" \
            "zsh-syntax-highlighting (Install)" \
        || return 1
    else
        ask_for_confirmation "'$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting' already exits. Would you like to overwite it?"

        if [ answer_is_yes ];
        then
            execute \
                "rm -rf '$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting' && \
                    git clone $ZSH_SYNTAX_HIGHLIGHTING '$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting'" \
                "zsh-syntax-highlighting (Reinstallation)" \
            || return 1
        fi
    fi

    print_result $? "zsh-syntax-highlighting"

}


install_zsh_autosuggestions() {

    local ZSH_AUTOSUGGESTIONS="https://github.com/zsh-users/zsh-autosuggestions"

    if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ];
    then
        execute \
            "git clone $ZSH_AUTOSUGGESTIONS '$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions'" \
            "zsh-autosuggestions (Install)" \
        || return 1
    else

        ask_for_confirmation "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions already exists. Would you like to overwrite it?"

        if [ answer_is_yes ];
        then
            execute \
                "rm -rf '$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions' && \
                    git clone $ZSH_AUTOSUGGESTIONS '$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions'" \
                "zsh-autosuggestions (Reinstallation)" \
            || return 1
        fi
    fi

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
