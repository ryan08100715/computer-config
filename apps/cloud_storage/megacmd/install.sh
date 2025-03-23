#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# 確認作業系統
distribution=$(detect_os)

if [[ $distribution == "Ubuntu" ]]; then
  # 目前只支援 Ubuntu 24.04
  if [[ $(detect_os_version) != "24.04" ]]; then
    echo "目前只支援 Ubuntu 24.04"
    exit 1
  fi

  # 已經安裝則退出
  if command_is_exist "bat"; then
    exit
  fi

  # * 下載 deb 檔案到暫存資料夾
  tempDir=$(create_temp_dir)
  url="https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megacmd-xUbuntu_24.04_amd64.deb"
  curl -s -L -o "$tempDir/megacmd.deb" "$url"

  # * 使用 apt 安裝 deb 檔案
  sudo apt-get install -y "$tempDir/megacmd.deb"

  # * 刪除暫存資料夾
  rm -rf "$tempDir"
else
  echo "不支援的系統: $distribution"
fi
