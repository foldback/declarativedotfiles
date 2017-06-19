# macOS
# gpg.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="SSH"
  Cloud="Dropbox"
  GPGpath=("${HOME}/${Cloud}/dev/dotfiles/.gpg" "${HOME}/.gpg")

  # Abracadabra
  checkCloud
  baklink "${GPGpath}"
  configureGPG
}

main
