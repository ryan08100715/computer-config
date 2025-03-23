#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [ "$distribution" = "Ubuntu" ]; then
  # install
  ppa="ppa:fish-shell/release-3"
  if ! is_ppa_added ${ppa#ppa:}; then
    sudo apt-add-repository -y $ppa
    sudo apt-get update
    sudo apt-get install -y fish
  fi

  # link config
  mkdir -p ~/.config/fish
  ln -sf "$SCRIPT_DIR/config/config.fish" "$HOME/.config/fish/config.fish"
  mkdir -p ~/.config/fish/functions
  ln -sf "$SCRIPT_DIR/config/functions/ls.fish" "$HOME/.config/fish/functions/ls.fish"

  # Add fisher
  source "$HOME/.bashrc"
  fish "$SCRIPT_DIR/fisher_install.fish"
else
  echo "不支援的系統: $distribution"
fi
