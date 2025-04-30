#!/usr/bin/env bash

# 檢查是否以 root 權限運行
if [[ $EUID -ne 0 ]]; then
  echo "此腳本需要以 root 權限運行，請使用 sudo"
  exit 1
fi

# 建立使用者
sudo adduser ryan

# 添加 sudo 權限
sudo usermod -aG sudo ryan

# 添加 metadata 到 wsl.conf
WSL_CONF="/etc/wsl.conf"
echo -e "\n[automount]\noptions = \"metadata\"" >>"$WSL_CONF"
