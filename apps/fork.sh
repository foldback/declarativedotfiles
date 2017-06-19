# macOS
# fork.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Fork"
  Packagename="fork"

  # Abracadabra
  brewApp
}

main
