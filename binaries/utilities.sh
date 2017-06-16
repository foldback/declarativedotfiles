# macOS
# utilities.sh
# © Jorrit Visser // github.com/jorvi


configUtilities() {
  printf "Symlinking ${Name} settings.. "

  for Dotfile in ${HOME}/dotfiles/.{aliases,curlrc,editorconfig,exports\
  ,functions,hushlogin,inputrc}; do
    ln -sF "${Dotfile}" "${HOME}/${Dotfile}"
  done;

  # Cloud ~/bin sync
  cp -r "${HOME}/${Cloud}/dev/bin" "${HOME}" && \
  rm -rf "${HOME}/${Cloud}/dev/bin" && \
  ln -sF "${HOME}/bin" "${HOME}/${Cloud}/dev"

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Utilities"
  Cloud="Dropbox"

  # Abracadabra
  configUtilities
}

main
