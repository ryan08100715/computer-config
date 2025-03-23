#!/usr/bin/env bash

# import utils
SCRIPT_DIR=$(dirname "$0")

# * 配置設定檔
mkdir -p "$HOME/.config/lsd"
ln -sf "$(realpath "$SCRIPT_DIR")/config/config.yaml" "$HOME/.config/lsd/config.yaml"

# * 配置 bash alias
alias_command="alias ls='lsd'"

# 檢查是否已存在
if ! grep -qF "$alias_command" "$HOME/.bashrc"; then
  # 如果不存在，則添加到 ~/.bashrc
  echo "$alias_command" >>"$HOME/.bashrc"
fi
