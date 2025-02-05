#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# * 確認作業系統
distribution=$(detect_os)

# * 檢查依賴
exit_on_commands_not_exist "curl" "jq"

if [[ $distribution == "Ubuntu" ]]; then
  # * 取得下載URL
  url=$(get_github_asset_download_url "lsd-rs/lsd" "^lsd_.*_amd64.deb$")
  if [ -z "$url" ]; then
    echo "Error: 無法取得 .deb 檔案下載 URL"
    exit 1
  fi

  # * 下載 deb 檔案到暫存資料夾
  tempDir=$(create_temp_dir)
  curl -s -L -o "$tempDir/lsd.deb" "$url"

  # * 使用 apt 安裝 deb 檔案
  sudo apt-get install -y "$tempDir/lsd.deb"

  # * 刪除暫存資料夾
  rm -rf "$tempDir"
else
  echo "不支援的系統: $distribution"
fi
