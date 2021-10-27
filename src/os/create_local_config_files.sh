# /bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_gitconfig_local() {

    declare -r FILE_PATH="$HOME/.gitconfig.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -e $FILE_PATH ] || [ -z "$FILE_PATH" ];
    then
        print_in_purple "\n  • Setting up gitconfig\n\n"

        ask "What is your github author name? "
        AUTHORNAME="$(get_answer)"

        ask "What is you github email? "
        EMAIL="$(get_answer)"

        printf \
            "[user]
                    name = %s
                    email = %s" \
            $AUTHORNAME \
            $EMAIL \
            >> $FILE_PATH
    fi

    print_result $? "$FILE_PATH"

}

create_vimrc_local() {

    declare -r FILE_PATH="$HOME/.vimrc.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ ! -e "$FILE_PATH" ]; then
        printf "" >> "$FILE_PATH"
    fi

    print_result $? "$FILE_PATH"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n ‣ Create local config files\n\n"

    create_gitconfig_local
    create_vimrc_local

}

main
