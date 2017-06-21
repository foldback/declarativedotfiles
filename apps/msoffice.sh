# macOS
# msoffice.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Microsoft Office"
  Packagename="microsoft-office"

  # Abracadabra
  brewApp
}

main
