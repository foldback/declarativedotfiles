# macOS
# xcode.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureXcode() {
  printf "Configuring ${Name}.. "

  # Enable key repeat
  defaults write com.apple.dt.Xcode ApplePressAndHoldEnabled -bool false

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write com.apple.dt.Xcode NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write com.apple.dt.Xcode NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write com.apple.dt.Xcode NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write com.apple.dt.Xcode NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write com.apple.dt.Xcode NSAutomaticSpellingCorrectionEnabled -bool false

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
  baklink "${Themepath[@]}"
  configureXcode
  dockApp
  message "${Messagetext}"
}

main
