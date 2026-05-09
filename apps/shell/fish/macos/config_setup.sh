#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

mkdir -p ~/.config/fish
ln -sf "$(realpath "$SCRIPT_DIR/../config/config.fish")" "$HOME/.config/fish/config.fish"

mkdir -p ~/.config/fish/functions
for file in "$SCRIPT_DIR/../config/functions/"*.fish; do
    ln -sf "$(realpath "$file")" "$HOME/.config/fish/functions/$(basename "$file")"
done
