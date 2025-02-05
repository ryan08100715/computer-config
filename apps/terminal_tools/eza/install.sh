#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# 確認作業系統
distribution=$(detect_os)

if [[ $distribution == "Ubuntu" ]]; then
  # 已經安裝則退出
  if command_is_exist "eza"; then
    exit
  fi

  # 添加 PPA
  sudo mkdir -p /usr/share/keyrings
  key_path="/usr/share/keyrings/gierens.gpg"
  repo_path="/etc/apt/sources.list.d/gierens.list"
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o "$key_path"
  echo "deb [signed-by=$key_path] http://deb.gierens.de stable main" | sudo tee "$repo_path"
  sudo chmod 644 "$key_path" "$repo_path"
  sudo apt-get update
  sudo apt-get install -y eza
else
  echo "不支援的系統: $distribution"
fi
