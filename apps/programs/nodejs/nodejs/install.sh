#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [ "$distribution" = "Ubuntu" ]; then
  if ! command_is_exist "volta"; then
    echo "尚未安裝 volta, 請先安裝 volta 在安裝 nodejs"
    exit
  fi

  volta install node
else
  echo "不支援的系統: $distribution"
fi
