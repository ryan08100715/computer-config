#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# 確認作業系統
distribution=$(detect_os)

if [[ $distribution == "Ubuntu" ]]; then
  # 已經安裝則退出
  if command_is_exist "fd"; then
    exit
  fi

  # 從 github 安裝最新版本
  temp_dir=$(mktemp -d)
  GITHUB_USER="sharkdp"
  GITHUB_REPO="fd"
  latest_version=$(curl --silent "https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  download_url="https://github.com/$GITHUB_USER/$GITHUB_REPO/releases/download/$latest_version/fd_${latest_version#v}_amd64.deb"
  file_path="$temp_dir/fd_$latest_version.deb"
  echo "Start installing the package: fd"
  echo "Fetching: $download_url"
  curl --progress-bar -L -o "$file_path" "$download_url"
  echo "Installing..."
  sudo apt-get install -y "$file_path" >/dev/null
  rm -r "$temp_dir"

  echo "Installed successfully!"
else
  echo "不支援的系統: $distribution"
fi
