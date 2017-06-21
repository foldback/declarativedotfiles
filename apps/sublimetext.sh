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

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write com.sublimetext.3 NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write com.sublimetext.3 NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write com.sublimetext.3 NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write com.sublimetext.3 NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write com.sublimetext.3 NSAutomaticSpellingCorrectionEnabled -bool false

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
