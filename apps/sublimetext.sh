# macOS
# sublimetext.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureSublime() {
  printf "Configuring ${Name} extensions.. "

  # Make sure configuration files and directories exist
  open -a "Sublime Text" && sleep 5 && osascript -e 'quit app "Sublime Text"'

  # Install latest Package Control
  mkdir "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages" && \
  curl -o "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package" \
  "https://packagecontrol.io/Package%20Control.sublime-package" 1>/dev/null

  # Enable key repeat for Vim-mode
  defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Sublime Text"
  Packagename="sublime-text"
  Sublimepath=($"{HOME}/dotfiles/.sublimetext/User" \
  "${HOME}/Library/Application Support/Sublime Text 3/Packages/User")

  # Abracadabra
  brewApp
  changeIcon
  configureSublime
  baklink "${=Atompath}"
}

main
