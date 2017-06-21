# macOS
# vim.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Vim"
  Packagename="vim --with-override-system-vi"
  Vimrcpath=("${HOME}/dotfiles/.vimrc" "${HOME}/.vimrc")
  Vimrcpath=("${HOME}/dotfiles/.vim" "${HOME}/.vim")

  # Abracadabra
  brewBinary
  baklink "${Vimrcpath[@]}"
  baklink "${Vimpath[@]}"
}

main
