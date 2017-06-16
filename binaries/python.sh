# macOS
# python.sh
# © Jorrit Visser // github.com/jorvi


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Python"
  Packagename="python"
  brewBinary
  Packagecommand="pip install"
  Packagelist=("")

  # Abracadabra
  brewBinary
  installPackages "${Packagelist}"

  # Declare name, package name, etc.
  Name="Python 3"
  Packagename="python3"
  brewBinary
  Packagecommand="pip3 install"
  Packagelist=("")

  # Abracadabra
  brewBinary
  installPackages "${Packagelist}"
}

main
