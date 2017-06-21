# macOS
# iterm2.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureIterm2() {
    printf "Configuring ${Name}.. "

  # Enable Secure Keyboard Entry in iTerm2
  # See: https://security.stackexchange.com/a/47786/8918
  defaults write com.googlecode.iterm2 "Secure Input" -bool true

  # Use the Oceanic Next Dark theme in iTerm2
  open "${HOME}/dotfiles/assets/themes/Oceanic_Next_iTerm2"\
  && sleep 5 && osascript -e 'quit app "iTerm2"'

  # Set font and font size in iTerm2
  sed -i "" 's/Monaco\ 12/SourceCodePro-Regular\ 15/g'\
  "${HOME}/Library/Preferences/com.googlecode.iterm2.plist" 1>/dev/null

  # Don’t display the annoying prompt when quitting iTerm2
  defaults write com.googlecode.iterm2 PromptOnQuit -bool false

  # Hide tip of the day
  defaults write com.googlecode.iterm2 NoSyncTipsDisabled -bool true

  # Fix window manager (Magnet.me, Spectacle, Moom) resizing bug
  # https://gitlab.com/gnachman/iterm2/issues/4771
  defaults write com.googlecode.iterm2 DisableWindowSizeSnap -bool true

  # Enable arrow scrolling behaviour in iTerm2
  defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true

  # Enable key repeat for Vim-mode
  defaults write com.googlecode.iterm2 ApplePressAndHoldEnabled -bool false

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write com.googlecode.iterm2 NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  defaults write com.googlecode.iterm2 NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write com.googlecode.iterm2 NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  defaults write com.googlecode.iterm2 NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write com.googlecode.iterm2 NSAutomaticSpellingCorrectionEnabled -bool false

  printf "done!\n"
}


main() {
  Name="iTerm2"
  Packagename="iterm2"
  brewApp
  configureIterm2
}

main
