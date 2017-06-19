# macOS
# duti.sh
# © Jorrit Visser <git.io/jorvi>


configureDuti() {
  printf "Configuring ${Name}.. "

  # Save appended data to variable
  local UTIlist="$(sed -n 25,42p ${HOME}/dotfiles/duti.sh)"

  # Set associations
  while read UTIline; do
    duti -s "${UTIline}"
  done < "${UTIlist}"

  # Cleanup
  brew uninstall duti

  # Exit
  printf "Done!\n"
  return 0
}

# Bundle id              UTI/.ext/MIME-type  role

# `Sublime Text`
com.sublimetext.3        public.source-code  editor

# `The Unarchiver`
cx.c3.theunarchiver      public.archive      all

# Disk Image Mounter
# Stops `The Unarchiver` from opening .dmg files
com.apple.DiskImageMounter  .dmg             all

# `Transmission`
org.m0k.transmission        .torrent         all
org.m0k.Transmission        magnet

# `VLC`
org.videolan.vlc         public.movie        viewer

main() {
    # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Duti"
  Packagename="duti"
  Messagetext="File types succesfully associated!"

  # Abracadabra
  brewBinary
  configureDuti
  message "${Messagetext}"
}

main
