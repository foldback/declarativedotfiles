# macOS
# xcode.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureXcode() {
  printf "Configuring ${Name}.. "

  # Enable key repeat
  defaults write com.apple.dt.Xcode ApplePressAndHoldEnabled -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Xcode"
  Packagename="497799835"
  Themepath=("${HOME}/dotfiles/assets/themes/FontAndColorThemes" "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes")
  Messagetext="Remember to choose the 'Oceanic Dark' theme in Preferences -> Fonts and Colors"

  # Abracadabra
  masApp
  mvlink "${=Themepath}"
  configureXcode
  dockApp
  message "${Messagetext}"
}

main
