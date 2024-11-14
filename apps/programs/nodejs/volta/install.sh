#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [ "$distribution" = "Ubuntu" ]; then
  if command_is_exist "volta"; then
    exit
  fi

  # install volta
  curl https://get.volta.sh | bash
else
  echo "不支援的系統: $distribution"
fi
