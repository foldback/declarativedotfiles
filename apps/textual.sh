# macOS
# textual.sh
# © Jorrit Visser <git.io/jorvi>


configureTextual() {
  printf "Configuring ${Name}.. "

  # Disable smart quotes as they’re annoying when typing code
  defaults write com.codeux.irc.textual5 NSAutomaticQuoteSubstitutionEnabled -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Textual"
  Packagename="896450579"

  # Abracadabra
  masApp
  configureTextual
}

main
