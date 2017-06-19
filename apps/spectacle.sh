# macOS
# spectacle.sh
# © Jorrit Visser <git.io/jorvi>


configureSpectacle() {
  printf "Configuring ${Name}.. "

  # Create Spectacle settings directory if it doesn't exist
  if [ ! -d "${HOME}/Library/Application Support/Spectacle/" ]; then
    mkdir -p "${HOME}/Library/Application Support/Spectacle/"
  fi;

  # Backup existing configuration
  mv "${HOME}/Library/Application Support/Spectacle/Shortcuts.json" \
  "${HOME}/Library/Application Support/Spectacle/Shortcuts.json_backup"

  # Symlink configuration
  ln -sF "${HOME}/dotfiles/assets/Spectacle_shortcuts.json" \
  "${HOME}/Library/Application Support/Spectacle/Shortcuts.json"

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Spectacle"
  Packagename="spectacle"

  # Abracadabra
  brewApp
  configureSpectacle
}

main
