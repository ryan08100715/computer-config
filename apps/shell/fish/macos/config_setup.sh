#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

mkdir -p ~/.config/fish
ln -sf "$SCRIPT_DIR/../config/config.fish" "$HOME/.config/fish/config.fish"

mkdir -p ~/.config/fish/functions
for file in "$SCRIPT_DIR/../config/functions/"*.fish; do
    ln -sf "$file" "$HOME/.config/fish/functions/$(basename "$file")"
done
