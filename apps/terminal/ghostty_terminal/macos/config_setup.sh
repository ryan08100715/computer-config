#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
ln -sf "$(realpath "$SCRIPT_DIR/../config/config.ghostty")" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
