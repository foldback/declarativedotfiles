# macOS
# vscode.sh
# © Jorrit Visser // github.com/jorvi


# Specific quirks that can't be functionized go here
configureVSCode() {
  printf "Configuring ${Name}.. "

  # Make sure configuration files and directories exist
  open -a "Visual Studio Code" && sleep 5 && osascript -e 'quit app "Visual Studio Code"'

  # Enable key repeat for Vim-mode
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Visual Studio Code"
  Packagename="visual-studio-code"
  Packagescmd="code --install-extension"
  Packageslist=("dbaeumer.vscode-eslint" "donjayamanne.python" \
  "naumovs.theme-oceanicnext" "ms-vscode.cpptools" \
  "vscodevim.vim")
  VSCodepath=("${HOME}/dotfiles/.vscode/User" "${HOME}/Library/Application Support/Code/User")

  # Abracadabra
  brewApp
  changeIcon
  configureVSCode
  baklink "${=VSCodepath}"
  installPackages "${=Packageslist}"
}

main
