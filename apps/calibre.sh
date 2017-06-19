# macOS
# calibre.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scriptfuncs.shlib"

  # Declare name, package name, and paths
  Name="Calibre"
  Packagename="calibre"
  Cloud="Dropbox"
  Calibrepath=("${HOME}/${Cloud}/eBooks" "${HOME}/Calibre Library")

  # Abracadabra
  brewApp
  checkCloud
  cplinkDir "${=Calibrepath}"
}

main
