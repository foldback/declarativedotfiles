# macOS
# androidtools.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Android Platform Tools"
  Packagename="android-platform-tools"

  # Abracadabra
  brewApp
}

main
