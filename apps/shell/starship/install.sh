#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [ "$distribution" = "Ubuntu" ]; then
  if command_is_exist "starship"; then
    exit
  fi

  # install
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
else
  echo "不支援的系統: $distribution"
fi
