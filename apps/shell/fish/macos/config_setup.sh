#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

mkdir -p ~/.config/fish
ln -sf "$SCRIPT_DIR/../config/config.fish" "$HOME/.config/fish/config.fish"

mkdir -p ~/.config/fish/functions
ln -sf "$SCRIPT_DIR/../config/functions/ls.fish" "$HOME/.config/fish/functions/ls.fish"
