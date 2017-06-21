# macOS
# zsh.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureZsh() {
  printf "Installing ${Name} modules.. "

  # Install Zim
  # Clone, including submodules, with parallel downloading, and run install script
  git clone --recursive -j8 "https://github.com/jorvi/zim.git" "${HOME}/.zim" 1>/dev/null && \
  sh -c "~/.zim/tools/zim_install" 1>/dev/null

  # Change zim theme
  #sed -i "" 's/steeef/naaative/g' "${HOME}/.zimrc"

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Zsh"
  Packagename="zsh"
  Zshpath=("${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc")

  # Abracadabra
  brewBinary
  configureZsh
  baklink "${Zshpath[@]}"
}

main
