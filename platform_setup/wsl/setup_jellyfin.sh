#!/usr/bin/env bash

# * 更新系統
sudo apt-get update
sudo apt-get upgrade -y

# * 安裝常用工具
sudo apt-get install -y zip unzip curl

# * 安裝 Jellyfin
curl https://repo.jellyfin.org/install-debuntu.sh | sudo bash
