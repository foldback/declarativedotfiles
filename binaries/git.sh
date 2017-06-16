# macOS
# git.sh
# © Jorrit Visser // github.com/jorvi


configureGit() {
  printf "Setting up ${Name}.. "

  # Backup existing configuration
  mv "${HOME}/.gitconfig" "${HOME}/.gitconfig_backup"

  # Modified by ~/.private, so can't be symlinked from the repo
  cp -f "${HOME}/dotfiles/.gitconfig" "${HOME}/.gitconfig"

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Git"
  Packagename="git"
  Gitattribpath=("${HOME}/dotfiles/.gitattributes_global" "${HOME}/.gitattributes_global")
  Gitignorepath=("${HOME}/dotfiles/.gitattributes_global" "${HOME}/.gitignore_global")

  # Abracadabra
  brewBinary
  baklink "${Gitattribpath}"
  baklink "${Gitattribpath}"
  configureGit
}
