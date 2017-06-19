# macOS
# cloud.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureCloud() {
  printf "Configuring "${Name}".. "

  # Move `Photos library` to ~/ to prevent eternal syncing
  open -a "Photos" && sleep 5 && osascript -e 'quit app "Photos"'
  mv -i "${HOME}/Pictures/Photos Library.photoslibrary" \
  "${HOME}/Photos Library.photoslibrary"

  # Secure directories with proper permissions
  for Directory in \
  "${HOME}/Documents" \
  "${HOME}/Pictures" \
  "${HOME}/dev/dotfiles/.private"; do
    chown -R "$(id -un)" "${Directory}"
    chmod 600 "${Directory}"
  done;

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Dropbox"
  Packagename="dropbox"
  Cloud="${Name}"
  Documentspath=("${HOME}/Documents" "${HOME}/${Cloud}/Documents")
  Picturespath=("${HOME}/Pictures" "${HOME}/${Cloud}/Pictures")
  Privatepath=("${HOME}/${Cloud}/dev/dotfiles/.private" "${HOME}/.private")

  # Abracadabra
  brewApp
  checkCloud
  cplinkDir "${=Documenstpath}"
  cplinkDir "${=Picturespath}"
  baklink "${=Privatepath}"
  configureCloud
}

main
