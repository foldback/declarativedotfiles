# macOS
# gnu.sh
# © Jorrit Visser // github.com/jorvi


main() {
  # Load the magic library
  source "${HOME}/dotfiles/scripts/ddfunlib"

  # Declare name, package name, etc.
  Name="GNU"
  Packagescmd="brew install"
  Packageslist=("binutils" "coreutils" "diffutils" "findutils" "ed" "gawk" "gnutls" "grep" \
  "gzip" "gnu-indent" "gnu-sed" "gnu-tar" "gnu-env which" "moreutils" "screen" \
  "watch" "wdiff --with-gettext" "wget --with-iri")
  Messagetext="All GNU commands are prefixed with a \`g\`, example: \`ggrep\`\n"

  # Abracadabra
  configureGNU
  installPackages "${Packageslist}"
  message "${Messagetext}"
}

main
