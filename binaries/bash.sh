# macOS
# bash.sh
# © Jorrit Visser // github.com/jorvi


main() {
    # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Bash"
  brewBinary
  Packagescmd="brew install"
  Packagelist=("bash-completion@2")
  Bashprofilepath=("${HOME}/dotfiles/bash_profile" "{HOME}/bash_profile")
  Bashpromptpath=("${HOME}/dotfiles/bash_prompt" "{HOME}/bash_prompt")
  Bashrcpath=("${HOME}/dotfiles/bashrc" "{HOME}/bashrc")

  # Abracadabra
  brewBinary
  baklink "${Bashprofilepath}"
  baklink "${Bashpromptpath}"
  baklink "${Bashrcpath}"
  installPackages "${=Packageslist}"
}

main

