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
