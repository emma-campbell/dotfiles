#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

change_default_shell() {

    local configs=""
    local pathConfig=""

    local newShellPath=""
    local brewPrefix=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Try to get the path of the `Bash`
    # version installed through `Homebrew`.

    brewPrefix="$(brew_prefix)" \
        || return 1

    pathConfig="PATH=\"$brewPrefix/bin:\$PATH\""
    configs="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
$pathConfig
export PATH
"

    newShellPath="$brewPrefix/bin/zsh" \

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the `Bash` version installed through `Homebrew`
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for her own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep "$newShellPath" < /etc/shells &> /dev/null; then
        execute \
            "printf '%s\n' '$newShellPath' | sudo tee -a /etc/shells" \
            "zsh (add '$newShellPath' in '/etc/shells')" \
        || return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set latest version of `Bash` as the default
    # (macOS uses by default an older version of `Bash`).

    chsh -s "$newShellPath" &> /dev/null
    print_result $? "zsh (use latest version)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_oh_my_zsh() {

    export ZSH="$HOME/dotfiles/.ohmyzsh"

    if [ ! -d $ZSH ];
    then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        ask_for_confirmation "$ZSH already exists. Would you like to overwrite it?"

        if [ answer_is_yes ];
        then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugins() {

    local ZSH_CUSTOM_PLUGINS="$ZSH/custom/plugins"
    local ZSH_CUSTOM_THEMES="$ZSH/custom/themes"

    local ZSH_SYNTAX_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    local ZSH_AUTOSUGGESTIONS="https://github.com/zsh-users/zsh-autosuggestions"
    local ZSH_APPLE_TOUCHBAR="https://github.com/zsh-users/zsh-apple-touchbar"

    local TYPEWRITTEN="https://github.com/reobin/typewritten"

    print_in_purple "\n    Installing zsh-syntax-highlighting\n\n"
    git clone $ZSH_SYNTAX_HIGHLIGHTING "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"

    print_in_purple "\n    Installing zsh-autosuggestions\n\n"
    git clone $ZSH_AUTOSUGGESTIONS "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions"

    print_in_purple "\n    Installing ZSH touchbar support\n\n"
    git clone $ZSH_APPLE_TOUCHBAR "$ZSH_CUSTOM_PLUGINS/zsh-apple-touchbar"

    print_in_purple "\n    Installing Typewritten theme\n\n"
    git clone $TYPEWRITTEN "$ZSH_CUSTOM_THEMES/typewritten"
    ln -s "$ZSH_CUSTOM_THEMES/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM_THEMES/typewritten.zsh-theme"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   zsh\n\n"

    brew_install "zsh" "zsh" \
        && change_default_bash

    brew_install "zsh completions" "zsh-completions"

    install_plugins

}

main
