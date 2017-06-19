# macOS
# safaritechpreview.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configureSafariPreview() {
  printf "Configuring ${Name}.. "

  # Press Tab to highlight each item on a web page
  defaults write com.apple.SafariTechnologyPreview WebKitTabToLinksPreferenceKey -bool true
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

  # Show the full URL in the address bar (note: this still hides the scheme)
  defaults write com.apple.SafariTechnologyPreview ShowFullURLInSmartSearchField -bool true

  # Show Chrome-style status bar
  defaults write com.apple.SafariTechnologyPreview ShowOverlayStatusBar -bool true

  # Set Safari’s home page to `about:blank` for faster loading
  defaults write com.apple.SafariTechnologyPreview HomePage -string "about:blank"

  # Prevent Safari from opening ‘safe’ files automatically after downloading
  defaults write com.apple.SafariTechnologyPreview AutoOpenSafeDownloads -bool false

  # Allow hitting the Backspace key to go to the previous page in history
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

  # Hide Safari’s bookmarks bar by default
  defaults write com.apple.SafariTechnologyPreview ShowFavoritesBar -bool false

  # Hide Safari’s sidebar in Top Sites
  defaults write com.apple.SafariTechnologyPreview ShowSidebarInTopSites -bool false

  # Don't show frequently visited sites in Top bar
  defaults write com.apple.SafariTechnologyPreview ShowFrequentlyVisitedSites -bool false

  # Disable Safari’s thumbnail cache for History and Top Sites
  defaults write com.apple.SafariTechnologyPreview DebugSnapshotsUpdatePolicy -int 2

  # Enable Safari’s debug menu
  defaults write com.apple.SafariTechnologyPreview IncludeInternalDebugMenu -bool true

  # Make Safari’s search banners default to Contains instead of Starts With
  defaults write com.apple.SafariTechnologyPreview FindOnPageMatchesWordStartsOnly -bool false

  # Remove useless icons from Safari’s bookmarks bar
  defaults write com.apple.SafariTechnologyPreview ProxiesInBookmarksBar "()"

  # Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.SafariTechnologyPreview IncludeDevelopMenu -bool true
  defaults write com.apple.SafariTechnologyPreview WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  # Add a context menu item for showing the Web Inspector in web views
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  # Enable continuous spellchecking
  defaults write com.apple.SafariTechnologyPreview WebContinuousSpellCheckingEnabled -bool true
  # Disable auto-correct
  defaults write com.apple.SafariTechnologyPreview WebAutomaticSpellingCorrectionEnabled -bool false

  # Disable AutoFill
  defaults write com.apple.SafariTechnologyPreview AutoFillFromAddressBook -bool false
  defaults write com.apple.SafariTechnologyPreview AutoFillPasswords -bool false
  defaults write com.apple.SafariTechnologyPreview AutoFillCreditCardData -bool false
  defaults write com.apple.SafariTechnologyPreview AutoFillMiscellaneousForms -bool false

  # Warn about fraudulent websites
  defaults write com.apple.SafariTechnologyPreview WarnAboutFraudulentWebsites -bool true

  # Disable plug-ins
  defaults write com.apple.SafariTechnologyPreview WebKitPluginsEnabled -bool false
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

  # Disable Java
  defaults write com.apple.SafariTechnologyPreview WebKitJavaEnabled -bool false
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

  # Block pop-up windows
  defaults write com.apple.SafariTechnologyPreview WebKitJavaScriptCanOpenWindowsAutomatically -bool false
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

  # Disable auto-playing video
  defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
  defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

  # Disable “Do Not Track”
  # Largely ignored by advertising networks and makes `fingerprinting` much easier
  defaults write com.apple.SafariTechnologyPreview SendDoNotTrackHTTPHeader -bool false

  # Privacy: don’t send search queries to Apple
  #defaults write com.apple.SafariTechnologyPreview UniversalSearchEnabled -bool false
  #defaults write com.apple.SafariTechnologyPreview SuppressSearchSuggestions -bool true

  # Update extensions automatically
  defaults write com.apple.SafariTechnologyPreview InstallExtensionUpdatesAutomatically -bool true

  # No nag screens
  defaults write com.apple.SafariTechnologyPreview DidActivateReaderAtleastOnce -bool true
  defaults write com.apple.SafariTechnologyPreview UniversalSearchFeatureNotificationHasBeenDisplayed -bool true

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Safari Technology Preview"
  Packagename="safari-technology-preview"
  Messagetext="Remember to set 'Safari Technology Preview' as the default browser!\n"

  # Abracadabra
  brewApp
  configureSafariPreview
  dockApp
  message "${Messagetext}"
}

main
