#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# link config
ln -sf "$(realpath "$SCRIPT_DIR/config/config_wsl")" "$HOME/.gitconfig"
