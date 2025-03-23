#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/../../../utils/utils.sh"

# detect os
distribution=$(detect_os)

if [[ $distribution == "Ubuntu" ]]; then
  if command_is_exist "pwsh"; then
    echo "已經安裝 powershell，進行更新..."
    sudo apt-get install -y powershell
  else
    # Update the list of packages
    sudo apt-get update

    # Install pre-requisite packages.
    sudo apt-get install -y wget apt-transport-https software-properties-common

    # 檢查是否添加過 sources
    if ! is_ppa_added "packages.microsoft.com"; then
      # Get the version of Ubuntu
      source /etc/os-release

      # Download the Microsoft repository keys
      wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

      # Register the Microsoft repository keys
      sudo dpkg -i packages-microsoft-prod.deb

      # Delete the Microsoft repository keys file
      rm packages-microsoft-prod.deb

      # Update the list of packages after we added packages.microsoft.com
      sudo apt-get update
    fi

    # Install PowerShell
    sudo apt-get install -y powershell
  fi
else
  echo "不支援的系統: $distribution"
fi
