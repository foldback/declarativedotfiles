# macOS
# ssh.sh
# © Jorrit Visser // github.com/jorvi


configureSSH() {
  printf "Configuring ${Name}.. "

  # Secure SSH with proper permissions
  chown -R $(id -un) "${HOME}/${2}/dev/dotfiles/.ssh" && \
  chmod 700 "${HOME}/${Cloud}/dev/dotfiles/.ssh" && \
  chmod 600 "${HOME}/${Cloud}/dev/dotfiles/.ssh/id_rsa" && \
  chmod 644 "${HOME}/${Cloud}/dev/dotfiles/.ssh/id_rsa.pub"

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="SSH"
  Cloud="Dropbox"
  SSHpath=("${HOME}/${Cloud}/dev/dotfiles/.ssh" "${HOME}/.ssh")

  # Abracadabra
  checkCloud
  baklink "${SSHpath}"
  configureSSH
}

main
