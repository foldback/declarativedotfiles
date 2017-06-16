# macOS
# systemsetup.sh
# © Jorrit Visser // github.com/jorvi


setupCore() {
  spawnSudo

  for Script in ${HOME}/dotfiles/scripts/binaries/{brew,node}.sh; do
    ${Script}
  done;

  ${HOME}/dotfiles/scripts/macos.sh

  killSudo
}

setupDev() {
  for Script in ${HOME}/dotfiles/scripts/apps/{androidtools,chrome,iterm2,fork,spectacle,sublimetext,unarchiver,xcode}.sh; do
    ${Script}
  done;

  for Script in ${HOME}/dotfiles/scripts/binaries/{bash,python,ruby,utilities,vim,zsh}.sh; do
    ${Script}
  done;

  ${HOME}/dotfiles/scripts/fonts.sh
}

setupConsumer() {
  for Script in ${HOME}/dotfiles/{1password,amphetamine,airparrot,calibre,etcher,pixelmator,ransomwhere,spotify,telegram,textual,transmission,vlc,viscosity,whatsapp}.sh; do
    ${Script}
  done;
}

setupLast() {
  for Script in ${HOME}/dotfiles/{cloud,duti,gpg,ssh}.sh; do
    ${Script}
  done;
}

main() {
  setupConsumer
  setupDev
  setupConsumer
  setupLast
}

main
