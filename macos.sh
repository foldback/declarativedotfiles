# macOS
# macos.sh
# Turns macOS from bearable to brilliant


# These settings are for macOS 10.12 (Sierra)
# Sourced from lots of places, Mathias Bynens in particular

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront if needed
if [ ! "${UID}" = 0 ]; then
  sudo -v
fi;
# Keep-alive: update existing `sudo` until script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "${$}" || return
done; &

###############################################################################
# General UI/UX
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
#COMPUTER_NAME="Mars"
#sudo scutil --set ComputerName "${COMPUTER_NAME}"
#sudo scutil --set HostName "${COMPUTER_NAME}"
#sudo scutil --set LocalHostName "${COMPUTER_NAME}"
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${COMPUTER_NAME}"
#unset COMPUTER_NAME

# Set standby delay to 24 hours (default is 1 hour)
#sudo pmset -a standbydelay 86400

# Disable the sound effects on boot
# Stopped working since 10.10 (Yosemite)
# https://github.com/mathiasbynens/dotfiles/issues/517
# Your Mac also uses this sound channel for hardware error codes
#sudo nvram SystemAudioVolume="%80"

# Disable transparency in the menu bar and elsewhere on macOS
#defaults write com.apple.universalaccess reduceTransparency -bool true

# Menu bar: hide the Time Machine, Bluetooth and User icons
defaults -currentHost write dontAutoLoad -array \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
  "/System/Library/CoreServices/Menu Extras/User.menu"

# Load icons in this order: Clock, Battery, Airport, Volume
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Volume.menu" \
  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Set the clock to only display the time
defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Set highlight color to blue (default)
defaults delete NSGlobalDomain AppleHighlightColor >/dev/null 2>&1

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Contextually show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Disable the over-the-top focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Disable smooth scrolling
# (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Increase window resize speed for Cocoa applications
# Stopped working since 10.11 (El Capitan)
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Enable App Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool true

# Enable automatic termination of inactive apps
# This works more like hibernating than terminating
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool false

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Set macOS `CoreFoundation` encoding and prefered language to UTF8 + English
# See https://superuser.com/questions/82123/mac-whats-cfusertextencoding-for
# Can break Adobe apps on very rare occasions
mv -f "${HOME}/.CFUserTextEncoding" "${HOME}/.CFUserTextEncoding_backup"
printf "0x08000100:0x0" > "${HOME}/.CFUserTextEncoding"

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
#sudo systemsetup -setcomputersleep Off >/dev/null

# Power button shows shutdown dialog instead of sleeping
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool false

# Disable Notification Center and remove the menu bar icon
#launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist >/dev/null 2>&1

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -Rf ${HOME}/Library/Application Support/Dock/desktoppicture.db
#sudo rm -Rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# Enable Quick Look text selection
# Stopped working since 10.11 (El Capitan)
#defaults write com.apple.finder QLEnableTextSelection -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
#sudo systemsetup -settimezone "Europe/Amsterdam" 1>dev/null

# Sync with a pool of time servers instead of just one, increasing accuracy
# 'pool.ntp.org' uses geographically close servers automatically
# Also slightly increase privacy by not contacting Apple for time corrections
sudo systemsetup -setusingnetworktime on
sudo systemsetup -setnetworktimeserver "pool.ntp.org"

# Change DNS servers to a combination of Google and OpenDNS
networksetup -setdnsservers Wi-Fi "8.8.8.8" "8.8.4.4" "208.67.222.222" "208.67.220.220"

###############################################################################
# SSD-specific tweaks
###############################################################################

# Disable hibernation (speeds up entering sleep mode)
# Very risky. If your Mac loses power in standby, you lose all unsaved work
#sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
#sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
#sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
#sudo chflags uchg /private/var/vm/sleepimage

###############################################################################
# Input and Bluetooth
###############################################################################

# Enable tap to click for this user and on the login screen
# Trackpads
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write -currentHost com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -currentHost com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Magic Mouse
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -bool true

# Trackpad: Map bottom right corner to right-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Force Touch-trackpads
# Make clicks silent
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad -bool false
# Medium pressure to register first click
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad -int 0
# Light cumulative pressure to register second level click
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad -int 0

# Three finger window drag and text selection (old screen dragging with four fingers)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -bool false

# Enable “natural” (smartphone-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Set trackpad & mouse sensitivity to a reasonable number
# User and machine-wide
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2.0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.scaling -float 1.5
defaults -currentHost write NSGlobalDomain com.apple.mouse.scaling -float 2.0

# Increase sound quality for Bluetooth headphones/headsets
#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable tab-select for list and text boxes only
# Much more efficient, see: http://superuser.com/a/547501
defaults write NSGlobalDomain AppleKeyboardUIMode -int 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Enable keyboard press-and-hold pop-up
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Set language and text formats
# Note: if you’re in the US, replace 'EUR' with 'USD', 'Centimeters' with
# 'Inches', 'en_NL' with 'en_US', and 'true' with 'false'.
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_NL@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Show language menu in the top right corner of the login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# Disable automatic capitalization as it’s annoying when typing code
#defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keep keyboard backlight on indefinitely
# Value is in seconds
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor.plist "Keyboard Dim Time" -int 0

# Enable F1-F12, hold fn for media functions
# This makes debuggers much easier to use
#defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist >/dev/null 2>&1

###############################################################################
# Screen
###############################################################################

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable light subpixel font rendering
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
#sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

# Allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Disable window animations and Get Info animations
#defaults write com.apple.finder DisableAllAnimations -bool true

# Set the user directory as the default location for new Finder windows
# For other paths, use 'PfLo' and 'file:///full/path/here/'
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Hide status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Hide path bar
defaults write com.apple.finder ShowPathbar -bool false

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by Name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Shorten the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.35

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo bool true" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo bool true" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Add :FK_StandardViewSettings:IconViewSettings:showItemInfo bool true" "${HOME}/Library/Preferences/com.apple.finder.plist"

# Show item info on the bottom of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom bool true" "${HOME}/Library/Preferences/com.apple.finder.plist"

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy string grid" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy string grid" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy string grid" "${HOME}/Library/Preferences/com.apple.finder.plist"

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing integer 95" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing integer 95" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing integer 95" "${HOME}/Library/Preferences/com.apple.finder.plist"

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize integer 80" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize integer 80" "${HOME}/Library/Preferences/com.apple.finder.plist"
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize integer 80" "${HOME}/Library/Preferences/com.apple.finder.plist"

# Disable icon previews
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showIconPreview bool false" "${HOME}/Library/Preferences/com.apple.finder.plist"
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showIconPreview bool false" "${HOME}/Library/Preferences/com.apple.finder.plist"
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showIconPreview bool false" "${HOME}/Library/Preferences/com.apple.finder.plist"

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: 'icnv', 'Nlsv', 'Flwv'
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Arrange items by Kind
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"

# Sort items by Name
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop on Ethernet and pre-2011 Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Enable the MacBook Air SuperDrive on any Mac
# Stopped working since 10.11 (El Capitan) due to System Integrity Protection
#sudo nvram boot-args="mbasd=1"

# Show the ~/Library folder
chflags nohidden "${HOME}/Library"

# Show the /Volumes folder
sudo chflags nohidden "/Volumes"

# Remove Dropbox’s green checkmark icons in Finder
# Doesn't work anymore due to Dropbox integrity check
#file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
#[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

###############################################################################
# Dock, Dashboard, and Hot corners
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
#defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Biggest Dock icon size that uses reduced spacing
defaults write com.apple.dock tilesize -int 47

# Prevent accidental Dock resizing
defaults write com.apple.Dock size-immutable -bool yes

# Change minimize/maximize window effect to the faster `suck`
# Other options are `genie` (default) and `scale`
defaults write com.apple.dock mineffect -string "suck"

# Minimize windows to Dock instead of application icon
defaults write com.apple.dock minimize-to-application -bool false

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
#defaults write com.apple.dock static-only -bool true

# Animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool true

# Speed up Mission Control animations
# Stopped working since 10.12 (Sierra)
# Mission Control animation speed is now tied to gesture intensity
#defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't group windows by application in Mission Control
# Default is to group and stack them
defaults write com.apple.dock exposeNSGlobalDomainroup-by-app -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -int 0

# Enable the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -int 1

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Put the dock on the bottom
# To the left gives more screen-estate, but with autohide that doesn't matter
# and bottom dock is much more useful with multiple displays
defaults write com.apple.dock orientation -string "bottom"

# Disable the Launchpad gesture (pinch with thumb and three fingers)
#defaults write com.apple.dock showLaunchpadGestureEnabled -bool false

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add iOS and Watch Simulator to Launchpad
sudo ln -sF "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" "/Applications/Simulator.app"
sudo ln -sF "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Add a spacer to the left side of the Dock (where the applications are)
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Hot corners
# Possible values:
#  0: nothing
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Notification Center
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit
###############################################################################

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Show Chrome-style status bar
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Don't show frequently visited sites in Top bar
defaults write com.apple.Safari ShowFrequentlyVisitedSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Disable “Do Not Track”
# Largely ignored by advertising networks and makes `fingerprinting` much easier
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool false

# Privacy: don’t send search queries to Apple
#defaults write com.apple.Safari UniversalSearchEnabled -bool false
#defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# No nag screens
defaults write com.apple.Safari DidActivateReaderAtleastOnce -bool true
defaults write com.apple.Safari UniversalSearchFeatureNotificationHasBeenDisplayed -bool true

###############################################################################
# Mail
###############################################################################

# Enable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool false
defaults write com.apple.mail DisableSendAnimations -bool false

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Enable automatic spell checking
defaults write com.apple.mail SpellCheckingBehavior -string "InlineSpellCheckingEnabled"

###############################################################################
# Spotlight
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
#sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# 10.10+ (Yosemite) specific search results
# Remove if your macOS is older
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Load new settings before rebuilding the index
killall mds 1>/dev/null
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / 1>/dev/null
# Rebuild the index from scratch
sudo mdutil -E / 1>/dev/null

###############################################################################
# Address Book
###############################################################################

# Enable the debug menu in Address Book
defaults write com.apple.addressbook ABShowDebugMenu -bool true

# Order & show by `Firstname Lastname`
defaults write com.apple.AddressBook ABNameDisplay -int 0
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

###############################################################################
# Calendar
###############################################################################

# Time zone support active by default
defaults write com.apple.iCal "TimeZone support enabled" -bool true

# Show event times
defaults write com.apple.iCal "Show time in Month View" -bool true

# show week numbers by default
defaults write com.apple.iCal "Show Week Numbers" -bool true

# Turn on birthday calendar
defaults write com.apple.iCal "display birthdays calendar" -bool true

# Enable the debug menu in iCal
# Stopped working since 10.8 (Mountain Lion)
#defaults write com.apple.iCal IncludeDebugMenu -bool true

###############################################################################
# Terminal
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use Oceanic Next Dark theme in Terminal.app
osascript <<EOD
tell application "Terminal"

  local allOpenedWindows
  local initialOpenedWindows
  local windowID
  set themeName to "Oceanic_Next_Terminal-app"

  (* Store the IDs of all the open terminal windows. *)
  set initialOpenedWindows to id of every window

  (* Open the custom theme so that it gets added to the list
     of available terminal themes (note: this will open two
     additional terminal windows). *)
  do shell script "open '${HOME}/dotfiles/resources/themes/" & themeName & ".terminal'"

  (* Wait a little bit to ensure that the custom theme is added. *)
  delay 1

  (* Set the custom theme as the default terminal theme. *)
  set default settings to settings set themeName

  (* Get the IDs of all the currently opened terminal windows. *)
  set allOpenedWindows to id of every window

  repeat with windowID in allOpenedWindows

    (* Close the additional windows that were opened in order
       to add the custom theme to the list of terminal themes. *)
    if initialOpenedWindows does not contain windowID then
      close (every window whose id is windowID)

    (* Change the theme for the initial opened terminal windows
       to remove the need to close them in order for the custom
       theme to be applied. *)
    else
      set current settings of tabs of (every window whose id is windowID) to settings set themeName
    end if

  end repeat

end tell
EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Enable key repeat for Vim-mode
defaults delete com.apple.Terminal ApplePressAndHoldEnabled false

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -bool false

# Only show scroll bars when scrolling
defaults write com.apple.Terminal AppleShowScrollBars -string "WhenScrolling"

###############################################################################
# Security & Privacy
###############################################################################

# Login & Password
# Require password immediately after sleep or screen saver begins
# Delay is in seconds
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Ask for both name and password
#sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Do not show password hints
#sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

# Disable guest account login
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Remove power off and restart buttons on login window
#sudo defaults write /library/preferences/com.apple.loginwindow PowerOffDisabled -bool true

# Enable firewall
# 0 is off, 1 for `normal` mode, 2 allows only essential services
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Enable firewall stealth mode
# Source: https://support.apple.com/kb/PH18642
#sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true

# Automatically allow signed software to receive incoming connections
sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool true
sudo defaults write /Library/Preferences/com.apple.alf allowdownloadsignedenabled -bool true

# Enable firewall logging
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true

# Log firewall events for 90 days
sudo sed -i "" 's/appfirewall.log file_max=5M all_max=50M/appfirewall.log rotate=utc compress file_max=5M ttl=90/g' "/etc/asl.conf"

# Logging <3
# Most logging is managed by the `Apple System Log` facility since 10.9 (Mavericks)
# secure.log has been rolled into system.log
# Log system events for 90 days
sudo sed -i "" 's/system\.log mode=0640 format=bsd rotate=seq compress file_max=5M all_max=50M/system\.log mode=0640 format=bsd rotate=utc compress file_max=5M ttl=90/g' "/etc/asl.conf"
# Log authentication events for 90 days
sudo sed -i "" 's/\/var\/log\/authd\.log mode=0640 compress format=bsd rotate=seq file_max=5M all_max=20M/\/var\/log\/authd\.log mode=0640 compress format=bsd rotate=utc file_max=5M ttl=90/g' "/etc/asl/com.apple.authd"
# Log installation events for a year
sudo sed -i "" 's/\/var\/log\/install\.log format=bsd/\/var\/log\/install\.log format=bsd mode=0640 rotate=utc compress file_max=5M ttl=365/g' "/etc/asl/com.apple.install"
# Keep a log of kernel events for 30 days, and increase the scope of logging
sudo sed -i "" 's/flags:lo,aa/flags:lo,aa,ad,fd,fm,-all,\^-fa,\^-fc,\^-cl/g' "/private/etc/security/audit_control"
sudo sed -i "" 's/filesz:2M/filesz:10M/g' "/private/etc/security/audit_control"
sudo sed -i "" 's/expire-after:10M/expire-after:30d/g' "/private/etc/security/audit_control"

# Reload the firewall
# Stopped working since 10.11 (El Capitan) due to `System Integrity Protection`
#launchctl unload /System/Library/LaunchAgents/com.apple.alf.useragent.plist
#sudo launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist
#sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist
#launchctl load /System/Library/LaunchAgents/com.apple.alf.useragent.plist

# Disable file-sharing via AFP or SMB
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist

# Turn Bluetooth off completely
#sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
#sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist
#sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist

# Disable diagnostics & usage reports
#sudo launchctl unload -w /System/Library/LaunchDaemons/#com.apple.DiagnosticReportCleanUp.plist
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Crash Reporter appears as notification
defaults write com.apple.CrashReporter UseUNC -bool true

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Disable GateKeeper
# This is the “Are you sure you want to open this application?” dialog
# defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# Time Machine
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
#hash tmutil >/dev/null 2>&1 && sudo tmutil disablelocal

###############################################################################
# Activity Monitor
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show processes activity for last 8 hours in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 109

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Archive Utility, Dashboard, Disk Utility, TextEdit, Quicktime and Reminders
###############################################################################

# Move archive files to trash after expansion
# To delete directly, point to "/dev/null"
defaults write com.apple.archiveutility dearchive-move-after -string "${HOME}/.Trash"

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Enable the debug menu in Reminders
defaults write com.apple.reminders RemindersDebugMenu -boolean true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -bool true
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Auto-play videos when opened with QuickTime Player
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Mac App Store
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Photos
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Messages
###############################################################################

# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

################################END OF SCRIPT##################################


printf "macOS configured!\n"
printf "Restart to have all changes take effect!\n"
