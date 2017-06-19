# macOS
# duti.sh
# © Jorrit Visser <git.io/jorvi>


configureDuti() {
  printf "Configuring ${Name}.. "
  # Save appended data to file
  UTIlist="$(sed -n 22,57p ${HOME}/dotfiles/duti.sh)"

  # Set associations
  duti -s "${UTIlist}"

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
  #cx.c3.theunarchiver     .7z                 all
  #cx.c3.theunarchiver     .cab                all
  #cx.c3.theunarchiver     .gtar               all
  #cx.c3.theunarchiver     .gz                 all
  #cx.c3.theunarchiver     .hqx                all
  #cx.c3.theunarchiver     .jar                all
  #cx.c3.theunarchiver     .msi                all
  #cx.c3.theunarchiver     .rar                all
  #cx.c3.theunarchiver     .sit                all
  #cx.c3.theunarchiver     .tar                all
  #cx.c3.theunarchiver     .tar.gz             all
  #cx.c3.theunarchiver     .tar.xz             all
  #cx.c3.theunarchiver     .tgz                all
  #cx.c3.theunarchiver     .zip                all

  # Disk Image Mounter
  # Stops `The Unarchiver` from opening .dmg files
  com.apple.DiskImageMounter  .dmg             all

  # `Transmission`
  org.m0k.transmission        .torrent         all
  org.m0k.Transmission        magnet

  # `VLC`
  org.videolan.vlc         public.movie        viewer
  #org.videolan.vlc        .avi                viewer
  #org.videolan.vlc        .mkv                viewer
  #org.videolan.vlc        .mov                viewer
  #org.videolan.vlc        .mp4                viewer

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
