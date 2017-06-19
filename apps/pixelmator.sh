# macOS
# pixelmator.sh
# © Jorrit Visser <git.io/jorvi>


# Specific quirks that can't be functionized go here
configure_pixelmator() {
  printf "Configuring ${Name}.. "

  # Speed up Pixelmator by disabling the Intel HD3000 fix
  # Don't use on 2011 Macs!
  # http://support.pixelmator.com/viewtopic.php?f=5&t=14650
  defaults write com.pixelmatorteam.pixelmator PXCEnableOpenCLCPUBlit -bool false

  printf "done!\n"
}

main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="Pixelmator"
  Packagename="407963104"

  # Abracadabra
  masApp
  configurePixelmator
}

main
