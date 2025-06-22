mkcd() { mkdir -p "$1" && cd "$1"; }
reload() {
  source "$ZDOTDIR/.zshrc"
  echo "Reloaded from $ZDOTDIR/.zshrc"
}
