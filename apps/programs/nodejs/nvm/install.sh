#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [ "$distribution" = "Ubuntu" ]; then
  if command_is_exist "nvm"; then
    exit
  fi

  # install nvm
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

  # install nodejs
  source "$HOME/.nvm/nvm.sh"
  nvm install --lts

  fish "$SCRIPT_DIR/load_nvm.fish"
else
  echo "不支援的系統: $distribution"
fi
