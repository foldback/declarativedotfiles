# macOS
# 1password.sh
# © Jorrit Visser <git.io/jorvi>


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="1Password"
  Packagename="1password"

  # Abracadabra
  brewApp
}

main
