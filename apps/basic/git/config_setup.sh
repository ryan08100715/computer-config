#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

# link config
ln -sf "$SCRIPT_DIR/config/config" "$HOME/.gitconfig"
