# macOS
# vlc.sh
# © Jorrit Visser <git.io/jorvi>


configureVLC() {
  printf "Configuring ${Name}.. "

  # Create vlcrc if it doesn't exist
  if [ ! -f "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc" ]; then
    open -a "VLC" && sleep 5 && osascript -e 'quit app "VLC"'
  fi;

  # UI
  # Dark theme
  sed -i "" 's/#macosx-interfacestyle=0/macosx-interfacestyle=1/g' \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
  # Hide sidebar
  sed -i "" 's/#macosx-show-sidebar=1/macosx-show-sidebar=0/g' \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
  # Use native OS X fullscreen mode
  sed -i "" 's/#macosx-nativefullscreenmode=0/macosx-nativefullscreenmode=1/g' \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
  # Set default language English
  sed -i "" 's/#sub-language=/sub-language=English/g' \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"

  # Subtitles
  # Less gigantic size
  sed -i "" 's/#freetype-rel-fontsize=16/freetype-rel-fontsize=20/g' \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
  # Set font to `Tahoma`. "" instead of '' to prevent whitespace interpretation
  sed -i "" "s/#freetype-font=Arial Unicode MS/freetype-font=Tahoma/g" \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
  # Set encoding to Unicode
  sed -i "" 's/#subsdec-encoding=/subsdec-encoding=UTF-8/g' \
  "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"

  # Change VLC skin
  rm -Rf "/Applications/VLC.app/Contents/Resources" && \
  unzip "${1}/dotfiles/assets/VLC_theme.zip" \
  -d "/Applications/VLC/Contents" 1>/dev/null && \
  rm -Rf "/Applications/VLC/Contents/__MACOSX"


  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="VLC"
  Packagename"vlc"

  # Abracadabra
  brewApp
  changeIcon
  configureVLC
}

main
