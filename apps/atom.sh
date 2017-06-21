# macOS
# atom.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureAtom() {
  printf "Configuring ${1}.. "

  # Make sure configuration files and directories exist
  open -a "Atom" && sleep 5 && osascript -e 'quit app "Atom"'

  # Enable key repeat for Vim-mode
  defaults write com.github.atom ApplePressAndHoldEnabled -bool false

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write com.github.atom NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write com.github.atom NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write com.github.atom NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write com.github.atom NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write com.github.atom NSAutomaticSpellingCorrectionEnabled -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Atom"
  Packagename="atom"
  Packagescmd="apm install"
  Packageslist=("busy-signal" "intentions" \
  "oceanic-next" "linter" "linter-clang" \
  "linter-eslint" "linter-ui-default" \
  "vim-mode-plus" "vim-mode-plus-keymaps-for-surround")
  Atompath=("${HOME}/dotfiles/.atom" "${HOME}/.atom")

  # Abracadabra
  brewApp
  configureAtom
  baklink "${=Atompath}"
  installPackages "${=Packageslist}"
}

main
