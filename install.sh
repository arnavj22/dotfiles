#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

echo "Creating ~/.config directory if it doesn't exist..."
mkdir -p "$CONFIG_DIR"

CONFIG_FOLDERS=("zsh" "git" "gh" "iterm2-themes" "wezterm")

for folder in "${CONFIG_FOLDERS[@]}"; do
  TARGET="$CONFIG_DIR/$folder"
  SOURCE="$DOTFILES/.config/$folder"

  if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
    read -p "Config $TARGET exists. Overwrite? (y/n): " yn
    if [[ "$yn" =~ ^[Yy]$ ]]; then
      echo "Removing existing $TARGET"
      rm -rf "$TARGET"
    else
      echo "Skipping $TARGET"
      continue
    fi
  fi

  echo "Symlinking $SOURCE to $TARGET"
  ln -s "$SOURCE" "$TARGET"
done

# Symlink .zshenv separately
ZSHENV_TARGET="$HOME/.zshenv"
ZSHENV_SOURCE="$DOTFILES/zshenv"

if [ -L "$ZSHENV_TARGET" ] || [ -f "$ZSHENV_TARGET" ]; then
  read -p "$ZSHENV_TARGET exists. Overwrite? (y/n): " yn
  if [[ "$yn" =~ ^[Yy]$ ]]; then
    echo "Removing existing $ZSHENV_TARGET"
    rm -f "$ZSHENV_TARGET"
    echo "Symlinking $ZSHENV_SOURCE to $ZSHENV_TARGET"
    ln -s "$ZSHENV_SOURCE" "$ZSHENV_TARGET"
  else
    echo "Skipping $ZSHENV_TARGET"
  fi
else
  echo "Symlinking $ZSHENV_SOURCE to $ZSHENV_TARGET"
  ln -s "$ZSHENV_SOURCE" "$ZSHENV_TARGET"
fi

echo "Done! Restart your terminal or source your configs."
