# macOS
# pigz.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Pigz"
  Packagename="pigz"

  # Abracadabra
  brewBinary
}

main
