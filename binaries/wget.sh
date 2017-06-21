# macOS
# wget.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Wget"
  Packagename="wget"
  Wgetpath=("${HOME}/dotfiles/.wgetrc" "${HOME}/.wgetrc")

  # Abracadabra
  brewBinary
  baklink "${Wgetpath[@]}"
}

main
