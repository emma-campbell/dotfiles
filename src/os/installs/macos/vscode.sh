#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {
    execute "code --install-extension $2" "$1 (plugin)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code\n\n"                                :

# Install VSCode
brew_install "Visual Studio Code" "visual-studio-code" "--cask"

printf "\n"

# Install the VSCode plugins
install_plugin "Auto Close Tag" "formulahendry.auto-close-tag"
install_plugin "EditorConfig" "editorconfig.editorconfig"
install_plugin "Bracket Pair Colorizer" "coenraads.bracket-pair-colorizer"
install_plugin "Docker" "ms-azuretools.vscode-docker"
install_plugin "ESLint" "dbaeumer.vscode-eslint"
install_plugin "GitBlame" "waderyan.gitblame"
install_plugin "GitHub Copilot" "github.copilot"
install_plugin "GitLens" "eamodio.gitlens"
install_plugin "Indent Rainbow" "oderwat.indent-rainbow"
install_plugin "Jest Runner" "firsttris.vscode-jest-runner"
install_plugin "Markdown → PDF" "yzane.markdown-pdf"
install_plugin "Prettier" "esbenp.prettier-vscode"
install_plugin "Test Explorer" "hbenl.vscode-test-explorer"
install_plugin "Vetur" "octref.vetur"
install_plugin "IntelliCode" "visualstudioexptteam.vscodeintellicode"
install_plugin "VSCode-Icons" "vscode-icons-team.vscode-icons"

# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
