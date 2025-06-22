#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

echo "Creating ~/.config directory if it doesn't exist..."
mkdir -p "$CONFIG_DIR"

# List of config folders inside .config to symlink
CONFIG_FOLDERS=("zsh" "git" "gh")

for folder in "${CONFIG_FOLDERS[@]}"; do
  TARGET="$CONFIG_DIR/$folder"
  SOURCE="$DOTFILES/.config/$folder"

  if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
    echo "Removing existing $TARGET"
    rm -rf "$TARGET"
  fi

  echo "Symlinking $SOURCE to $TARGET"
  ln -s "$SOURCE" "$TARGET"
done

# Symlink .zshenv separately
ZSHENV_TARGET="$HOME/.zshenv"
ZSHENV_SOURCE="$DOTFILES/zshenv"

if [ -L "$ZSHENV_TARGET" ] || [ -f "$ZSHENV_TARGET" ]; then
  echo "Removing existing $ZSHENV_TARGET"
  rm -f "$ZSHENV_TARGET"
fi
echo "Symlinking $ZSHENV_SOURCE to $ZSHENV_TARGET"
ln -s "$ZSHENV_SOURCE" "$ZSHENV_TARGET"

echo "Done! Restart your terminal or source your configs."
