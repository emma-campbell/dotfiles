#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r ZSH_CUSTOM_PLUGINS="$ZSH/custom/plugins"
declare -r ZSH_CUSTOM_THEMES="$ZSH/custom/themes"

change_default_shell() {

    local configs=""
    local pathConfig=""

    local newShellPath=""
    local brewPrefix=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

    export ZSH="$HOME/.ohmyzsh"

    if [ ! -d $ZSH ];
    then
        execute \
            "sh -c $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "" --unattended --silent" \
            "ohmyzsh" \
        || return 1
    else
        ask_for_confirmation "$ZSH already exists. Would you like to overwrite it?"

        if [ answer_is_yes ];
        then
            execute \
                "rm -rf $ZSH" \
                "ohmyzsh (uninstall)" \
            || return 1
            execute \
                "sh -c $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "" --unattended --silent" \
                "ohmyzsh (reinstall)" \
            || return 1
        fi
    fi

    mv ~/.zshrc "../../../shell/oh-my-zshrc"

    print_result $? "ohmyzsh"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_zsh_syntax_highlighting() {

    local ZSH_SYNTAX_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"

    if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ];
    then
        execute \
            "git clone $ZSH_SYNTAX_HIGHLIGHTING $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" \
            "zsh-syntax-highlighting (Install)" \
        || return 1
    else
        ask_for_confirmation "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting already exits. Would you like to overwite it?"

        if [ answer_is_yes ];
        then
            execute \
                "rm -rf '$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting' && \
                    git clone $ZSH_SYNTAX_HIGHLIGHTING $ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" \
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

install_zsh_apple_touchbar() {

    local ZSH_APPLE_TOUCHBAR="https://github.com/zsh-users/zsh-apple-touchbar"

    if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-apple-touchbar" ];
    then
        execute \
            "git clone $ZSH_APPLE_TOUCHBAR '$ZSH_CUSTOM_PLUGINS/zsh-apple-touchbar'" \
            "zsh-apple-touchbar (Install)" \
        || return 1
    else

        ask_for_confirmation "$ZSH_CUSTOM_PLUGINS/zsh-apple-touchbar already exists. Would you like to overwrite it?"

        if [ answer_is_yes ];
        then
            execute \
                "rm -rf $ZSH_CUSTOM_PLUGINS/zsh-apple-touchbar" \
                "zsh-apple-touchbar (remove)" \
            || return 1

            execute \
                "git clone $ZSH_APPLE_TOUCHBAR '$ZSH_CUSTOM_PLUGINS/zsh-apple-touchbar'" \
                "zsh-apple-touchbar (install)" \
            || return 1
        fi
    fi

    print_result $? "zsh-apple-touchbar"
}

install_typewritten() {

    local TYPEWRITTEN="https://github.com/reobin/typewritten"

    if [ ! -f "$ZSH_CUSTOM_THEMES/typewritten.zsh-theme" ];
    then
        execute \
            "git clone $TYPEWRITTEN $ZSH_CUSTOM_THEMES/typewritten" \
            "typewritten (install)" \
        || return 1

        execute \
            "ln -s $ZSH_CUSTOM_THEMES/typewritten/typewritten.zsh-theme $ZSH_CUSTOM_THEMES/typewritten.zsh-theme" \
            "typewritten (link)" \
        || return 1

    else

        ask_for_confirmation "$ZSH_CUSTOM_THEMES/typewritten.zsh-theme already exists. Would you like to overwrite it?"

        if [ answer_is_yes ];
        then
            execute \
                "rm -rf $ZSH_CUSTOM_THEMES/typewritten && rm -rf $ZSH_CUSTOM_THEMES/typewritten.zsh-theme" \
                "typewritten (remove)" \
            || return 1

            execute \
                "git clone $TYPEWRITTEN '$ZSH_CUSTOM_THEMES/typewritten'" \
                "typewritten (install)" \
            || return 1

            execute \
                "ln -s $ZSH_CUSTOM_THEMES/typewritten/typewritten.zsh-theme $ZSH_CUSTOM_THEMES/typewritten.zsh-theme" \
                "typewritten (link)" \
            || return 1
        fi

    fi

    print_result $? "typewritten"
}


install_plugins() {
    install_zsh_syntax_highlighting && \
        install_zsh_autosuggestions && \
        install_zsh_apple_touchbar && \
        install_typewritten
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   zsh\n\n"

    brew_install "zsh" "zsh" \
        && change_default_shell \
        && install_oh_my_zsh \
        && install_plugins
}

main
