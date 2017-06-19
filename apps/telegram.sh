# macOS
# telegram.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Telegram"
  Packagename="telegram"

  # Abracadabra
  brewApp
}

main
