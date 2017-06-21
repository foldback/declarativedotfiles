# macOS
# vscode.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureVSCode() {
  printf "Configuring ${Name}.. "

  # Make sure configuration files and directories exist
  open -a "Visual Studio Code" && sleep 5 && osascript -e 'quit app "Visual Studio Code"'

  # Enable key repeat for Vim-mode
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write com.microsoft.VSCode NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write com.microsoft.VSCode NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write com.microsoft.VSCode NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write com.microsoft.VSCode NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write com.microsoft.VSCode NSAutomaticSpellingCorrectionEnabled -bool false

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
  baklink "${VSCodepath[@]}"
  installPackages "${Packageslist[@]}"
}

main
