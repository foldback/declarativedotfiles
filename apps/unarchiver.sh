# macOS
# unarchiver.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="The Unarchiver"
  Packagename="the-unarchiver"

  # Abracadabra
  brewApp
}

main
