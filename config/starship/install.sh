#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")

# link config
mkdir -p ~/.config
ln -sf "$SCRIPT_DIR/config/starship.toml" ~/.config/starship.toml
