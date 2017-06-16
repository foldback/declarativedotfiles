# macOS
# transmission.sh
# © Jorrit Visser // github.com/jorvi


# Specific quirks that can't be functionized go here
configureTransmission() {
  printf "Configuring ${Name}.. "

  # Set ~/Downloads as the default download directory
  defaults write org.m0k.transmission DownloadLocationConstant -bool true

  # Automatically load .torrent files in ~/Downloads
  defaults write org.m0k.transmission AutoImport -bool true
  defaults write org.m0k.transmission AutoImportDirectory-string "${HOME}/Downloads"

  # Trash original torrent file after adding
  defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

  # Auto-resize the window to fit transfers
  defaults write org.m0k.transmission AutoSize -bool true

  # Hide status bar
  defaults write org.m0k.transmission StatusBar -bool false

  # Only show download speed on Dock icon
  defaults write org.m0k.transmission BadgeDownloadRate -bool true
  defaults write org.m0k.transmission BadgeUploadRate -bool false

  # Prevent silent quit when downloading
  defaults write org.m0k.transmission CheckQuitDownloading -bool true
  defaults write org.m0k.transmission CheckRemoveDownloading -bool true

  # Don't prompt for confirmation before downloading
  defaults write org.m0k.transmission DownloadAsk -bool false
  defaults write org.m0k.transmission MagnetOpenAsk -bool false

  # Make Transmission somewhat safer to use
  # Using a VPN is still strongly advised
  defaults write org.m0k.transmission EncryptionRequire -bool true
  defaults write org.m0k.transmission RandomPort -bool true
  # Blocklists don't work
  # if a bad peer tries to connect, he's already aware you're sharing
  #defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
  #defaults write org.m0k.transmission BlocklistNew -bool true
  #defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"

  # Hide the legal disclaimer
  defaults write org.m0k.transmission WarningLegal -bool false

  # Hide the donation message
  defaults write org.m0k.transmission WarningDonate -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Transmission"
  Packagename="transmission"

  # Abracadabra
  brewApp
  configureTransmission
}

main
