# macOS
# ruby.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Ruby"
  Packagename="ruby"
  Packagecommand="gem install"
  Packagelist=("")

  # Abracadabra
  brewBinary
  installPackages "${Packagelist}"
}

main
