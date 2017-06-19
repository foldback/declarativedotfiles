# macOS
# perl.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Perl"
  Packagename="perl"
  Packagecommand=""
  Packagelist=("")

  # Abracadabra
  brewBinary
  installPackages "${Packagelist}"
}

main
