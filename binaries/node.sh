# macOS
# node.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Node"
  Packagename="npm"
  Packagecommand="npm install -g"
  Packagelist=("eslint")
  Eslintpath=("${HOME}/dotfiles/.eslintrc" "${HOME}/.eslintrc")

  # Abracadabra
  brewBinary
  installPackages "${Packagelist[@]}"
  baklink "${Eslintpath[@]}"
}

main

