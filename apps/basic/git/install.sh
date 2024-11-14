#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [[ $distribution == "Ubuntu" ]]; then
  # install
  # Ubuntu 24.04 不需要額外添加PPA
  if [[ $(detect_os_version) != "24.04" ]]; then
    ppa="ppa:git-core/ppa"
    if ! is_ppa_added ${ppa#ppa:}; then
      sudo add-apt-repository -y "$ppa"
    fi
  fi
  sudo apt-get update
  sudo apt-get install -y git

  # link config
  ln -sf "$SCRIPT_DIR/config/config" ~/.gitconfig
else
  echo "不支援的系統: $distribution"
fi
