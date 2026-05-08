#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
APPS_DIR="$SCRIPT_DIR/../../apps"

# * 安裝 fish
bash "$APPS_DIR/shell/fish/macos/install.sh"
bash "$APPS_DIR/shell/fish/macos/config_setup.sh"

# * 安裝 starship
bash "$APPS_DIR/shell/starship/macos/install.sh"
bash "$APPS_DIR/shell/starship/macos/config_setup.sh"

# * 安裝 iTerm2
bash "$APPS_DIR/terminal/iterm2_terminal/macos/install.sh"
